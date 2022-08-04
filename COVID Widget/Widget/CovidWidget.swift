//
//  CovidWidget.swift
//  HelloWidgetExtension
//
//  Created by DevTechie on 1/3/22.
//

import SwiftUI
import WidgetKit

@main
struct CovidWidget: Widget {
    private let kind = "CovidWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ShowCovidDataIntent.self, provider: CovidTimelineProvider()) { entry in
            StatsWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("COVID-19 Widget")
        .description("This widget shows current COVID-19 data.")
    }
}
