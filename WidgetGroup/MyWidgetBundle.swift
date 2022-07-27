//
//  MyWidgetBundle.swift
//  HelloWidgetExtension
//
//  Created by DevTechie on 1/2/22.
//

import SwiftUI
import WidgetKit

@main
struct MyWidgetBundle: WidgetBundle {
    var body: some Widget {
        HelloWidget()
        DateTimeWidget()
        QuoteWidget()
        WeatherWidget()
        CovidWidget()
    }
}
