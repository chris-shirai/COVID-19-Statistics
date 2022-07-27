//
//  WeatherEntry.swift
//  HelloWidgetExtension
//
//  Created by DevTechie on 1/3/22.
//

import WidgetKit

struct WeatherEntry: TimelineEntry {
    let date: Date
    let weatherInfo: [Weather]
}
