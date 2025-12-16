//
//  UClockWdgtExt.swift
//  PxClock
//
//  Created by leo on 2025.12.16.
//

//
//  UCWGext.swift
//  UCWGext
//
//  Created by wyw on 2022/3/30.
//

import WidgetKit
import SwiftUI
import Intents

typealias ConfigurationAppIntentU = PositionIntent

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntentU())
    }

    func getSnapshot(for configuration: ConfigurationAppIntentU, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        completion(SimpleEntry(date: Date(), configuration: configuration))
    }

    func getTimeline(for configuration: ConfigurationAppIntentU, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        
        if configuration.showsSec == 1 {
            for secOffset in 0..<60 { //原本是40
                let entryDate = Calendar.current.date(byAdding: .second, value: secOffset, to: currentDate)!
                let entry = SimpleEntry(date: entryDate, configuration: configuration)
                entries.append(entry)
            }
        } else { // every minute
            for minuteOffset in 0..<40 { //原本是40
                let startOfMinute: Date = Calendar.current.date(bySetting: .second, value: 0, of: Date())!
                let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: startOfMinute)!
                let entry = SimpleEntry(date: entryDate, configuration: configuration)
                entries.append(entry)
            }
        }

//        let timeline = Timeline(entries: entries, policy: .atEnd)//.after(Calendar.current.date(byAdding: .second, value: 30, to: currentDate)!))
        let timeline = Timeline(entries: entries, policy: .after(Calendar.current.date(byAdding: configuration.showsSec == 1 ? .second : .minute, value: 30, to: currentDate)!))
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntentU
}

struct UCWGextEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    @Environment(\.colorScheme) var colorScheme
    var entry: Provider.Entry
    var bgShape: UClockView.ClockShape
    
    let formatter: DateFormatter = {
        let fmt = DateFormatter()
        fmt.dateFormat = "HHmmss"
        return fmt
    }()
    
    var backgroundImage: UIImage? {
        if entry.configuration.bgPos == .unknown {return nil}
        let pos = family == .systemSmall
            ? entry.configuration.bgPos.rawValue
            : Int((entry.configuration.bgPos.rawValue + 1) / 2) + 6
        let pathB = "\(imgPath)/imgB\(pos).jpg"
        let pathD = "\(imgPath)/imgD\(pos).jpg"
        let savedImg = (colorScheme == .light)
            ? try? UIImage(data: Data(contentsOf: URL(fileURLWithPath: pathB)))
                ?? UIImage(data: Data(contentsOf: URL(fileURLWithPath: pathD)))
            : try? UIImage(data: Data(contentsOf: URL(fileURLWithPath: pathD)))
                ?? UIImage(data: Data(contentsOf: URL(fileURLWithPath: pathB)))
        return savedImg
    }
    
    func tunnedColor(for userColorTheme: ColorTheme, isFirstColor: Bool = true) -> Color {
        switch userColorTheme {
        case .blackwhite: return Color.gray
        case .auto:
            if isFirstColor {
                if let savedColor = ud.object(
                    forKey: colorScheme == .light ? "_IMG_COLOR_LIGHT_1" : "_IMG_COLOR_DARK_1"
                ) as? [CGFloat] {
                    return Color(hue: savedColor[0], saturation: savedColor[1], brightness: savedColor[2])
                } else {return Color.gray}
            } else {
                if let savedColor = ud.object(
                    forKey: colorScheme == .light ? "_IMG_COLOR_LIGHT_2" : "_IMG_COLOR_DARK_2"
                ) as? [CGFloat] {
                    return Color(hue: savedColor[0], saturation: savedColor[1], brightness: savedColor[2])
                } else {return Color.gray}
            }
        case .red: return Color.red
        case .orange: return Color.orange
        case .yellow: return Color.yellow
        case .green: return Color.green
        case .cyan: return Color.cyan
        case .blue: return Color.blue
        case .purple: return Color.purple
        case .pink: return Color.pink
        case .unknown: return Color.gray
        }
    }
    
    @ViewBuilder
    var clockView: some View {
        UClockView(
            dateFormat: entry.configuration.dateFormat,
            date: entry.date,
            firstColor: tunnedColor(for: entry.configuration.colorTheme),
            secondColor: tunnedColor(for: entry.configuration.colorTheme, isFirstColor: false),
            showSeconds: entry.configuration.showsSec == 1,
            showNumbers: entry.configuration.showsNumber == 1,
            shape: bgShape,
            bordered: entry.configuration.isBordered == 1,
            bg: backgroundImage,
            hor: Double(Int(formatter.string(from: entry.date))! / 10000),
            mnt: Double((Int(formatter.string(from: entry.date))! % 10000) / 100),
            sec: Double(Int(formatter.string(from: entry.date))! % 100)
        )
    }

    @ViewBuilder
    var body: some View {
        if #available(iOSApplicationExtension 17.0, *) {
            clockView
            .containerBackground(for: .widget) {
                Color(UIColor.systemGray6)
            }
        } else {
            clockView
            .background(Color(UIColor.systemGray6))
        }
    }
}

struct UCWG_Circle: Widget {
    let kind: String = "com.wyw.uclock.widget.circle"

    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind, intent: ConfigurationAppIntentU.self,
            provider: Provider()
        ) { entry in
            UCWGextEntryView(entry: entry, bgShape: .circle)
        }
        .configurationDisplayName("uclk_circle")
        .description("widget_desc")
        .supportedFamilies([.systemSmall, .systemMedium])
        .contentMarginsDisabled()
    }
}

struct UCWG_Scallop: Widget {
    let kind: String = "com.wyw.uclock.widget.scallop"

    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind, intent: ConfigurationAppIntentU.self,
            provider: Provider()
        ) { entry in
            UCWGextEntryView(entry: entry, bgShape: .scallop)
        }
        .configurationDisplayName("uclk_scallop")
        .description("widget_desc")
        .supportedFamilies([.systemSmall, .systemMedium])
        .contentMarginsDisabled()
    }
}

struct UCWG_Clover: Widget {
    let kind: String = "com.wyw.uclock.widget.clover"

    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind, intent: ConfigurationAppIntentU.self,
            provider: Provider()
        ) { entry in
            UCWGextEntryView(entry: entry, bgShape: .clover)
        }
        .configurationDisplayName("uclk_clover")
        .description("widget_desc")
        .supportedFamilies([.systemSmall, .systemMedium])
        .contentMarginsDisabled()
    }
}

struct UCWGext_Previews: PreviewProvider {
    static var previews: some View {
        UCWGextEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationAppIntentU()), bgShape: .scallop)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
