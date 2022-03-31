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
        for hourOffset in 0 ..< 15 {
            let entryDate = Calendar.current.date(byAdding: .second, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

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
    var entry: Provider.Entry
    var bgShape: FlowerClockView.ClockShape
    
    let formatter: DateFormatter = {
        let fmt = DateFormatter()
        fmt.dateFormat = "HHmmss"
        return fmt
    }()
    let colorHues: [Double?] = [
        nil, UserDefaults.standard.double(forKey: "_IMG_COLOR"), 0, 0.05, 0.11, 0.32, 0.5, 0.6, 0.73, 0.78, 0.88, nil
    ]

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
            dateFormat: entry.configuration.dateFormat,
            date: entry.date,
            fingerColorHue: colorHues[entry.configuration.colorTheme.rawValue],
            showSeconds: entry.configuration.showsSec == 1,
            showNumbers: entry.configuration.showsNumber == 1,
            shape: bgShape,
            bordered: entry.configuration.bordered == 1,
            hor: Double(Int(formatter.string(from: entry.date))! / 10000),
            mnt: Double((Int(formatter.string(from: entry.date))! % 10000) / 100),
            sec: Double(Int(formatter.string(from: entry.date))! % 100)
        ).padding().background(Color(UIColor.systemGray6))
    }
}

@main
struct UCWGext: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        UCWG_Rounded()
        UCWG_Flower()
    }
}

struct UCWG_Rounded: Widget {
    let kind: String = "UCWGext"

    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind, intent: ConfigurationIntent.self,
            provider: Provider()
        ) { entry in
            UCWGextEntryView(entry: entry, bgShape: .rounded)
        }
        .configurationDisplayName("Rounded Clock")
        .description("Material styled clock widget")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct UCWG_Flower: Widget {
    let kind: String = "UCWGext"

    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind, intent: ConfigurationIntent.self,
            provider: Provider()
        ) { entry in
            UCWGextEntryView(entry: entry, bgShape: .flower)
        }
        .configurationDisplayName("Flower Clock")
        .description("Material styled clock widget")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct UCWGext_Previews: PreviewProvider {
    static var previews: some View {
        UCWGextEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()), bgShape: .flower)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
