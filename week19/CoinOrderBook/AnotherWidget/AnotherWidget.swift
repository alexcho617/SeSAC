//
//  AnotherWidget.swift
//  AnotherWidget
//
//  Created by Alex Cho on 11/30/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct AnotherWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)
            
            Text("Emoji:")
            Text(entry.emoji)
            HStack{
                Link(destination: URL(string: "bookURL")!) {
                    Image(systemName: "book")
                        .frame(width: 30, height: 30)
                        .background(Color.white.opacity(0.5))
                        .clipShape(Circle())
                }
                
                Link(destination: URL(string: "favoriteURL")!) {
                    Image(systemName: "star")
                        .frame(width: 30, height: 30)
                        .background(Color.white.opacity(0.5))
                        .clipShape(Circle())
                }
                
            }
        }
    }
}

struct AnotherWidget: Widget {
    let kind: String = "AnotherWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                //위젯에 프레임과 배경 자동 설정
                //색 렌더링 모드도 다름
                AnotherWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                AnotherWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("위젯 링크 테스트")
        .description("위젯을 통한 화면 이동을 해볼게요")
        .supportedFamilies([.systemSmall, .systemMedium ,.systemLarge])
    }
}

#Preview(as: .systemSmall) {
    AnotherWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
