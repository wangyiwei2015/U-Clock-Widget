//
//  UCWGext.swift
//  UCWGext
//
//  Created by wyw on 2022/3/30.
//

import WidgetKit
import SwiftUI
import Intents

typealias ConfigurationIntent = PositionIntent

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        if configuration.showsSec == 1 {
            for hourOffset in 0 ..< 3600 {
                let entryDate = Calendar.current.date(byAdding: .second, value: hourOffset, to: currentDate)!
                let entry = SimpleEntry(date: entryDate, configuration: configuration)
                entries.append(entry)
            }
        } else {
            for hourOffset in 0 ..< 60 {
                let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset, to: currentDate)!
                let entry = SimpleEntry(date: entryDate, configuration: configuration)
                entries.append(entry)
            }
        }//每次更新60分钟的数据，结束后下一组时间线

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct UCWGextEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    @State var entry: Provider.Entry
    let formatter: DateFormatter = {
        let fmt = DateFormatter()
        fmt.dateFormat = "HHmmss"
        return fmt
    }()

    @ViewBuilder
    var body: some View {
//        switch family {
//        case .systemSmall:
//            Text(entry.date, style: .time)
//        case .systemMedium:
//            Text(entry.date, style: .time)
//        case .systemLarge:
//            Text(entry.date, style: .time)
//        default: fatalError()
//        }
        FlowerClockView(
            dateFormat: nil,
            fingerColorHue: entry.configuration.colorHue as? Double ?? 0.0,
            showSeconds: entry.configuration.showsSec == 1,
            showNumbers: entry.configuration.showsNumber == 1,
            shape: FlowerClockView.ClockShape(rawValue: entry.configuration.bgShape.rawValue - 1) ?? .flower,
            hor: Double(Int(formatter.string(from: entry.date))! / 10000),
            mnt: Double((Int(formatter.string(from: entry.date))! % 10000) / 100),
            sec: Double(Int(formatter.string(from: entry.date))! % 100)
        ).padding()
    }
}

@main
struct UCWGext: Widget {
    let kind: String = "UCWGext"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            UCWGextEntryView(entry: entry)
        }
        .configurationDisplayName("U Clock")
        .description("Material styled clock widget")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct UCWGext_Previews: PreviewProvider {
    static var previews: some View {
        UCWGextEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
