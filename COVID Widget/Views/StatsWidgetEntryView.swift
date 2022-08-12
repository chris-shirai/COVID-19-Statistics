//
//  StatsWidgetEntryView.swift
//  HelloWidgetExtension
//
//  Created by Chris Loreta on 7/26/22.
//

import SwiftUI
import WidgetKit

struct StatsWidgetEntryView: View {

    let entry: CovidEntry

    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall:
            StatsWidgetSmall(entry: entry)
        case .systemMedium:
            StatsWidgetMedium(entry: entry)
        default:
            StatsWidgetSmall(entry: entry)
        }

    }



}


//struct StatsWidgetEntryView_Previews: PreviewProvider {
//    static var previews: some View {
//        let covidCases = CovidCases(new: "100", active: 2, critical: 3, recovered: 5, total: 60)
//        let covidDeaths = CovidDeaths(new: "100", total: 200)
//        let covidInfo = [CovidCountry(continent: "us", country: "us", cases: covidCases, deaths: covidDeaths, time: "")]
//        let covidEntry = CovidEntry(date: Date(), covidInfo: covidInfo)
//
//        StatsWidgetEntryView(entry: covidEntry)
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
