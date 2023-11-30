//
//  Provider.swift
//  CoinOrderBook
//
//  Created by Alex Cho on 11/30/23.
//

import WidgetKit

//Target Membership Widget으로 설정
struct Provider: TimelineProvider {
    
    typealias Entry = SimpleEntry
    
    //데이터가 없을때 보여줄 데이터
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), test: "Alex", token: "Token1", price: 111111) //스켈레톤 뷰 같음
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), test: "Blex", token: "Token1", price: 222222)
        completion(entry)
    }
    
    
    //위젯 상태 변경 시점 구간 설정
//    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) { //associated type이기 떄문에 Concrete 하지 않음
//    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) { //해결 1
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) { // 타입 얼라이어스로해결 2
        var entries: [SimpleEntry] = [] //미리 만들어 놓음
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 { //미래 시간에 대한 뷰를 그릴 수 있도록 타임라인에 추가함
            let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: Date(), test: "SeSAC", token: "Ether", price: 333 * hourOffset)
            entries.append(entry)
        }
        
        //마지막 엔트리가 지나면 위젯킷이 새로운 다임라인을 요청할수 있도록 설정한다 (.atEnd)
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline) //미래에 시점이 계산되어서 보여지게 됨
    }
}
