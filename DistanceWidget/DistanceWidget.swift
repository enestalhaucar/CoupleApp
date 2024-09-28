//
//  DistanceWidget.swift
//  DistanceWidget
//
//  Created by Enes Talha Uçar  on 28.09.2024.
//

import WidgetKit
import SwiftUI
import SwiftData

struct DistanceProvider: AppIntentTimelineProvider {
    let sharedDefaults = UserDefaults(suiteName: "group.com.enestalhaucar.CoupleApp")
    
    func placeholder(in context: Context) -> DistanceEntry {
        DistanceEntry(date: Date(), distance: 0, configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> DistanceEntry {
        let distance = sharedDefaults?.double(forKey: "distance") ?? 0.0
        let entry = DistanceEntry(date: Date(), distance: distance, configuration: configuration)
        return entry
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<DistanceEntry> {
        let distance = sharedDefaults?.double(forKey: "distance") ?? 0.0
        let entry = DistanceEntry(date: Date(), distance: distance, configuration: configuration)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        
        return timeline
        
    }
}

struct DistanceEntry: TimelineEntry {
    let date: Date
    let distance : Double
    let configuration: ConfigurationAppIntent
}

struct DistanceWidgetEntryView : View {
    var entry: DistanceProvider.Entry

    var body: some View {
        ZStack {
            Image("mapbg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            HStack {
                Text("Distance: ")
                    .fontWeight(.heavy)
                Spacer()
                Text("\(String(format: "%.1f", entry.distance / 1000)) km")
                    .font(.title2)
                    .fontWeight(.heavy)
            }.padding(.horizontal)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        
    }
}

struct DistanceWidget: Widget {
    let kind: String = "DistanceWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: DistanceProvider()) { entry in
            DistanceWidgetEntryView(entry: entry)
                .containerBackground(.clear, for: .widget)
        }.configurationDisplayName("Distance Widget")
            .description("It shows distance from two user location.")
            .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
            .contentMarginsDisabled()
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemMedium) {
    DistanceWidget()
} timeline: {
    DistanceEntry(date: .now, distance: 123214.21312312, configuration: ConfigurationAppIntent.smiley)
}
