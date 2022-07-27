//
//  WeatherWidget.swift
//  HelloWidgetExtension
//
//  Created by DevTechie on 1/3/22.
//

import SwiftUI
import WidgetKit

struct WeatherWidget: Widget {
    private let kind = "WeatherWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WeatherTimelineProvider()) { entry in
            WeatherEntryView(entry: entry)
        }
        .configurationDisplayName("SF Weather Widget")
        .description("This widget shows current weather for SF.")
    }
}
