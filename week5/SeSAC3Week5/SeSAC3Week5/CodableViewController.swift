//
//  CodableViewController.swift
//  SeSAC3Week5
//
//  Created by Alex Cho on 2023/08/16.
//

import UIKit
import Alamofire

enum ValidationError: Error{
    case emptyString
    case isNotInt
    case isNotDate
}

class CodableViewController: UIViewController {
    var resultText: String = ""
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var checkButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func validateUserInput(text: String) -> Bool{
        //empty
        guard !(text.isEmpty) else{
            print("String Empty")
            return false
        }
        
        //number
        guard Int(text) != nil else {
            print("Not number")
            return false
        }
        
        //date
        guard checkDateFormat(text) else{
            print("Not Date")
            return false
        }
        
        return true
    }
    
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        guard let text = dateTextField.text else {return}
        
        do{
            let result = try validateUserInputError(text: text)
            print(result)
        } catch {
            print(error)
            
        }
    }
    
    func validateUserInputError(text: String) throws -> Bool{
        //empty
        guard !(text.isEmpty) else{
            throw ValidationError.emptyString
        }
        //number
        guard Int(text) != nil else {
            throw ValidationError.isNotInt
        }
        //date
        guard checkDateFormat(text) else{
            throw ValidationError.isNotDate
        }
        return true
    }
    
    //여기서 이미 다 걸러주지 않나?
    func checkDateFormat(_ text: String) -> Bool{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        guard let result = formatter.date(from: text) else {return false}
        return true
    }
    
//    func fetchTranslateData(source: String, target: String, text: String) {
//        print("fetchTranslateData", source, target, text)
//        let url = "https://openapi.naver.com/v1/papago/n2mt"
//        let header: HTTPHeaders = [
//            "X-Naver-Client-Id": Key.clientID,
//            "X-Naver-Client-Secret": Key.clientSecret
//        ]
//        let parameters: Parameters = [
//            "source": source,
//            "target": target,
//            "text": text
//        ]
//
//        AF.request(url, method: .post, parameters: parameters, headers: header)
//            .validate(statusCode: 200...500)
//            .responseDecodable(of: Translation.self) { response in
//
//                guard let value = response.value else { return }
//                self.resultText = value.message.result.translatedText
//                print("확인",self.resultText)
//                self.fetchTranslate(source: "ko", target: "en", text: self.resultText)//2 바꿔서 확인
//            }
//    }
//
//    func fetchTranslate(source: String, target: String, text: String) {
//        print("fetchTranslateData", source, target, text)
//        let url = "https://openapi.naver.com/v1/papago/n2mt"
//        let header: HTTPHeaders = [
//            "X-Naver-Client-Id": Key.clientID,
//            "X-Naver-Client-Secret": Key.clientSecret
//        ]
//        let parameters: Parameters = [
//            "source": source,
//            "target": target,
//            "text": text
//        ]
//
//        AF.request(url, method: .post, parameters: parameters, headers: header)
//            .validate(statusCode: 200...500)
//            .responseDecodable(of: Translation.self) { response in
//
//                guard let value = response.value else { return }
//                self.resultText = value.message.result.translatedText
//                print("최종",self.resultText)
//
//            }
//    }
//
//    func fetchLottoData() {
//        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1080"
//
//        DispatchQueue.global().async {
//            AF.request(url, method: .get).validate()
//                .responseData { response in
//                    guard let value = response.value else { return }
//                    print("responseData:", value)
//
//                    DispatchQueue.main.async {
//                        //레이블에 숫자 출력하기
//                    }
//                }
//        }
//        AF.request(url, method: .get).validate()
//            .responseString { response in
//                guard let value = response.value else { return }
//                print("responseString:", value)
//            }
//
//        AF.request(url, method: .get).validate()
//            .response { response in
//                guard let value = response.value else { return }
//                print("response:", value)
//            }
//
//                AF.request(url, method: .get).validate()
//                    .responseDecodable(of: Lotto.self) { response in
//                        guard let value = response.value else { return }
//                        print("responseDecodable:", value)
//                        print(value.bnusNo, value.drwtNo2)
//                    }
//
//    }

}

struct Lotto: Codable {
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}

struct Translation: Codable {
    let message: Message
}

// MARK: - Message
struct Message: Codable {
    let service, version: String
    let result: Result
    let type: String

    enum CodingKeys: String, CodingKey {
        case service = "@service"
        case version = "@version"
        case result
        case type = "@type"
    }
}

// MARK: - Result
struct Result: Codable {
    let engineType, tarLangType, translatedText, srcLangType: String
}
