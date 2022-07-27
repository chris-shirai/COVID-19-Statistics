//
//  CovidEntry.swift
//  HelloWidgetExtension
//
//  Created by Chris Loreta on 7/25/22.
//

import Foundation
import WidgetKit

struct CovidEntry: TimelineEntry {
    let date: Date
    let covidInfo: [Covid]
}
