//
//  SheikahWidget.swift
//  PxClock
//
//  Created by leo on 2025.12.17.
//
//
//  Created by leo on 2023-07-17.
//

import WidgetKit
import SwiftUI
import Intents
import AppIntents

struct IntentS: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "sheikah_wdgt_title"
    static var description = IntentDescription("This is an example widget.")
}

struct ProviderS: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SheikahWidgetEntry {
        SheikahWidgetEntry(date: .now, configuration: IntentS())
    }
    
    func snapshot(for configuration: IntentS, in context: Context) async -> SheikahWidgetEntry {
        return SheikahWidgetEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: IntentS, in context: Context) async -> Timeline<SheikahWidgetEntry> {
        var entries: [SheikahWidgetEntry] = []
        let currentDate = Date()
        for dayOffset in 0 ..< 14 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let theDay = Calendar.current.startOfDay(for: entryDate)
            let entry = SheikahWidgetEntry(date: theDay, configuration: configuration)
            entries.append(entry)
        }
        return Timeline(entries: entries, policy: .atEnd)
    }
    
    typealias Entry = SheikahWidgetEntry
    typealias Intent = IntentS
    
//    func recommendations() -> [IntentRecommendation<IntentS>] {
//        []
//    }
    
//    func placeholder(in context: Context) -> SheikahWidgetEntry {
//        SheikahWidgetEntry(date: Date(), configuration: IntentS())
//    }
//
//    func getSnapshot(for configuration: IntentS, in context: Context, completion: @escaping (SheikahWidgetEntry) -> ()) {
//        let entry = SheikahWidgetEntry(date: Date(), configuration: configuration)
//        completion(entry)
//    }
//
//    func getTimeline(for configuration: IntentS, in context: Context, completion: @escaping (Timeline<SheikahWidgetEntry>) -> ()) {
//        var entries: [SheikahWidgetEntry] = []
//        let currentDate = Date()
//        for dayOffset in 0 ..< 14 {
//            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
//            let theDay = Calendar.current.startOfDay(for: entryDate)
//            let entry = SheikahWidgetEntry(date: theDay, configuration: configuration)
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
//    }
}

struct SheikahWidgetEntry: TimelineEntry {
    let date: Date
    let configuration: IntentS
}

struct SheikahWidgetEntryView : View {
    var entry: ProviderS.Entry
    
    let d = DateFormatter()
    var displayText: String {
        d.dateFormat = "e:MM MMM\nddEEE"
        return d.string(from: entry.date).replacingOccurrences(of: " ", with: "")
    }

    var body: some View {
        ZStack {
            HStack(spacing: 6) {
                Text(displayText.split(separator: ":")[0])
                    .font(.custom("SheikahGlyphs", size: 30)).padding(5)
                    .offset(x: 2, y: 0.5)
                    .background(
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .fill(Color.black).offset(y: -1)
                    )
                VStack {
                    Text(displayText.split(separator: ":")[1])
                        .minimumScaleFactor(0.5)
                        .font(.custom("SheikahGlyphs", size: 20))
                }
            }
        }
    }
}

struct SheikahWidget: Widget {
    let kind: String = "com.wyw.sheikahwidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: IntentS.self, provider: ProviderS()) { entry in
            SheikahWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Sheikah Date")
        .description("e|MM,MMM;dd,EEE")
        .supportedFamilies([.accessoryRectangular])
    }
}

struct SheikahWidget_Previews: PreviewProvider {
    static var previews: some View {
        SheikahWidgetEntryView(entry: SheikahWidgetEntry(date: Date(), configuration: IntentS()))
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
    }
}
