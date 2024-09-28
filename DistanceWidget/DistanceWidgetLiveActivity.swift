//
//  DistanceWidgetLiveActivity.swift
//  DistanceWidget
//
//  Created by Enes Talha Uçar  on 28.09.2024.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct DistanceWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct DistanceWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DistanceWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension DistanceWidgetAttributes {
    fileprivate static var preview: DistanceWidgetAttributes {
        DistanceWidgetAttributes(name: "World")
    }
}

extension DistanceWidgetAttributes.ContentState {
    fileprivate static var smiley: DistanceWidgetAttributes.ContentState {
        DistanceWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: DistanceWidgetAttributes.ContentState {
         DistanceWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: DistanceWidgetAttributes.preview) {
   DistanceWidgetLiveActivity()
} contentStates: {
    DistanceWidgetAttributes.ContentState.smiley
    DistanceWidgetAttributes.ContentState.starEyes
}
