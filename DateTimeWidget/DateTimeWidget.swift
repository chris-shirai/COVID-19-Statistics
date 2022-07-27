//
//  DateTimeWidget.swift
//  HelloWidgetExtension
//
//  Created by DevTechie on 1/2/22.
//

import SwiftUI
import WidgetKit

struct DateTimeWidget: Widget {
    private let kind = "DateTimeWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: DateTimeTimelineProvider()) { entry in
            DateTimeEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall])
        .configurationDisplayName("Today")
        .description("Widget shows today's date")
    }
}
