//
//  SimpleEntry.swift
//  CoinWidgetExtension
//
//  Created by Alex Cho on 11/30/23.
//

import WidgetKit

//위젯을 구성하는데 필요한 데이터
//날짜는 무조건 있어야함 TimelineEntry Protocol에 의해
//Relevance는 스택 등 위젯 컨텐츠에 대한 사용자와의 연관성
struct SimpleEntry: TimelineEntry {
    let date: Date
    let test: String
    let token: String
    let price: Int
}


