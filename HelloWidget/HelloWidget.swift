//
//  HelloWidget.swift
//  HelloWidget
//
//  Created by DevTechie on 1/1/22.
//

import WidgetKit
import SwiftUI

struct HelloWidget: Widget {
    
    let kind = "HelloWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: HelloWidgetTimelineProvider()) { _ in
            HelloWidgetView()
        }
        .supportedFamilies([.systemSmall])
    }
}
