//
//  CoinWidget.swift
//  CoinWidget
//
//  Created by Alex Cho on 11/29/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    //데이터가 없을때 보여줄 데이터
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀") //스켈레톤 뷰 같음
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }
    
    
    //위젯 상태 변경 시점 구간 설정
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = [] //미리 만들어 놓음

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 { //미래 시간에 대한 뷰를 그릴 수 있도록 타임라인에 추가함
            let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }
        
        //마지막 엔트리가 지나면 위젯킷이 새로운 다임라인을 요청할수 있도록 설정한다 (.atEnd)
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline) //미래에 시점이 계산되어서 보여지게 됨
    }
}

//위젯을 구성하는데 필요한 데이터
struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

//위젯을 구성하는 뷰
struct CoinWidgetEntryView : View {
    var entry: Provider.Entry
    
    //위젯 사이즈에 따라 safearea 설정해야함. iOS16은 패딩으로 했으나 17에선 SafeArea가 따로 생김.
    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)

            Text("Emoji:")
            Text(entry.emoji)
        }
    }
}

struct CoinWidget: Widget {
    //unique widget identifier
    let kind: String = "CoinWidget"

    var body: some WidgetConfiguration { //3가지 컨피겨레이션이 있음
        //static 위젯
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                CoinWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget) //iOS17 modifier
            } else {
                CoinWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .accessoryInline, .accessoryCircular, .accessoryRectangular])
    }
}

#Preview(as: .systemSmall) {
    CoinWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
