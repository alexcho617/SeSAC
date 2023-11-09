//
//  APIModel.swift
//  SeSACRxSummery
//
//  Created by Alex Cho on 2023/11/09.
//

import Foundation


//엔드포인트당 인, 아웃 2개의 모델이 있다면 파일 관리를 잘 해야함 (2n 엔드포인트), 세분화 해도 됨
struct Join: Encodable{
    let email: String
    let password: String
    let nick: String
}

//응답이 온걸 확인하고 UD에 저장을 하고 뷰에서 처리
struct JoinnResponse: Decodable{
    let _id: String
    let email: String
    let nick: String
}

struct Login: Encodable{
    let email: String
    let password: String
}
