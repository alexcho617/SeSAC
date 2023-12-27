//
//  WebSocketManager.swift
//  WebSocket
//
//  Created by Alex Cho on 12/26/23.
//

import Foundation
import Combine

final class WebSocketManager: NSObject {
    static let shared = WebSocketManager()
    
    //NSObject의 init을 오버라이드
    private override init(){
        super.init()
    }
    
    private var webSocket: URLSessionWebSocketTask?
    private var timer: Timer?
    private var isOpen = false //Socket connection state
    //RX publishsubject vs Combine passthrough subject
    //behaviorsubject vs currentvaluesubject
    //rx 는 데이터만 설정 vs 컴바인은 에러타입도 설정
    var orderBookSubject = PassthroughSubject<OrderBookWS,Never>()
    
    func openWebSocket(){
        if let url = URL(string: "wss://api.upbit.com/websocket/v1"){
            let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
            webSocket = session.webSocketTask(with: url)
            webSocket?.resume()
            ping()
            
        }
    }
    
    func closeWebSocket(){
        //close code defined with enum
        webSocket?.cancel(with: .goingAway, reason: nil)
        webSocket = nil
        timer?.invalidate() //타이머는 RunLoop에서 VC생명주기랑 따로 동작하기 때문에 필요함
        isOpen = false
    }
    
    func send(){
        print(#function)
        let requestString = """
        [{"ticket":"test"},{"type":"orderbook","codes":["KRW-BTC"]}]
        """
        webSocket?.send(.string(requestString), completionHandler: { error in
            if let error{
                print("Send Error", error)
            }
        })
    }
    
    func receive(){
        print(#function)
        if isOpen{
            webSocket?.receive(completionHandler: { [weak self] result in
                switch result {
                case .success(let success):
//                    print("Receive Success",success)
                    switch success{
                    case .data(let data):
//                        print("Data",data)
                        if let decodedData = try? JSONDecoder().decode(OrderBookWS.self, from: data){
                            print("Decoded",decodedData)
                            self?.orderBookSubject.send(decodedData) //Rx onNext vs combine send
                        }
                        
                    case .string(let string):
                        print("String",string)
                    @unknown default: print("Unknown Error")
                    }
                case .failure(let failure):
                    print("Receive failure",failure)
                    self?.closeWebSocket()
                }
                self?.receive() //WWDC WebSocket
            })
            
        }
    }
    
    //연결이 끊어지지 않도록 주기적으로 핑을 서버에 보냄
    func ping(){
        print(#function)
        self.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { [weak self] _ in
            self?.webSocket?.sendPing(pongReceiveHandler: { error in
                if let error{
                    print("Ping Error", error)
                }else{
                    print("Ping")
                }
            })
        })
    }
}

//WebSocketDelegate는 이미 dataTaskDelegate, urlsessionDelegate를 이미 채택
//...> 따라서 최상위에는 NSObjectProtocol이 있으며 상속을 받아야함
extension WebSocketManager: URLSessionWebSocketDelegate{
    //연결 확인
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("WebSocket OPEN")
        isOpen = true
        //연결 후 메시지 받음
        receive()
    }
    
    //해제 확인
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("WebSocket CLOSE")
        isOpen = false
    }
    
}
