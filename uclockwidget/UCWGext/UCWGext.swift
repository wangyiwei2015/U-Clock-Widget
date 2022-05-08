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
            for secOffset in 0 ..< 30 {
                let entryDate = Calendar.current.date(byAdding: .second, value: secOffset, to: currentDate)!
                let entry = SimpleEntry(date: entryDate, configuration: configuration)
                entries.append(entry)
            }
        } else { // every minute
            for minuteOffset in 0 ..< 30 {
                let startOfMinute: Date = Calendar.current.date(bySetting: .second, value: 0, of: Date())!
                let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: startOfMinute)!
                let entry = SimpleEntry(date: entryDate, configuration: configuration)
                entries.append(entry)
            }
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)//.after(Calendar.current.date(byAdding: .second, value: 30, to: currentDate)!))
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
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
        return savedImg ?? nil
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
    var body: some View {
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
        ).background(Color(UIColor.systemGray6))
    }
}

@main
struct UCWGext: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        UCWG_Scallop()
        UCWG_Circle()
        UCWG_Clover()
    }
}

struct UCWG_Circle: Widget {
    let kind: String = "com.wyw.uclock.widget.circle"

    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind, intent: ConfigurationIntent.self,
            provider: Provider()
        ) { entry in
            UCWGextEntryView(entry: entry, bgShape: .circle)
        }
        .configurationDisplayName(localized("uclk_circle"))
        .description(localized("widget_desc"))
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct UCWG_Scallop: Widget {
    let kind: String = "com.wyw.uclock.widget.scallop"

    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind, intent: ConfigurationIntent.self,
            provider: Provider()
        ) { entry in
            UCWGextEntryView(entry: entry, bgShape: .scallop)
        }
        .configurationDisplayName(localized("uclk_scallop"))
        .description(localized("widget_desc"))
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct UCWG_Clover: Widget {
    let kind: String = "com.wyw.uclock.widget.clover"

    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind, intent: ConfigurationIntent.self,
            provider: Provider()
        ) { entry in
            UCWGextEntryView(entry: entry, bgShape: .clover)
        }
        .configurationDisplayName(localized("uclk_clover"))
        .description(localized("widget_desc"))
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct UCWGext_Previews: PreviewProvider {
    static var previews: some View {
        UCWGextEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()), bgShape: .scallop)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
