//
//  CovidWidget.swift
//  HelloWidgetExtension
//
//  Created by DevTechie on 1/3/22.
//

import SwiftUI
import WidgetKit

struct CovidWidget: Widget {
    private let kind = "CovidWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CovidTimelineProvider()) { entry in
            StatsWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("SF Covid Widget")
        .description("This widget shows current covid for SF.")
    }
}
