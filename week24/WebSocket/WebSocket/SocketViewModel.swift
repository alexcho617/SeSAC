//
//  SocketViewModel.swift
//  WebSocket
//
//  Created by Alex Cho on 12/26/23.
//

import Foundation
import Combine

class SocketViewModel: ObservableObject {
    @Published
    var askOrderBook: [OrderbookItem] = []
    
    @Published
    var bidOrderBook: [OrderbookItem] = []
    
    private var cancellable = Set<AnyCancellable>()
    init() {
        WebSocketManager.shared.openWebSocket()
        WebSocketManager.shared.send()
        //Rx Subscribe  vs Combine Sink
        //Rx Diposed vs Combine Cancellable
        //Rx Schedular vs Combine receive
        WebSocketManager.shared.orderBookSubject.receive(on: DispatchQueue.main)
            .sink { [weak self] order in
                guard let self else {return}
                
                self.askOrderBook = order.
                self.bidOrderBook = order.bidOrderBook
            }
            .store(in: &cancellable)
    }
    
    deinit {
        
        WebSocketManager.shared.closeWebSocket()
        print("SocketViewModel Deinit")
    }
}
