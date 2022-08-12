//
//  StatsWidgetMedium.swift
//  HelloWidgetExtension
//
//  Created by Chris Loreta on 7/26/22.
//

import SwiftUI
import WidgetKit

struct StatsWidgetMedium: View {

    let entry: CovidEntry

    var body: some View {

        if(!entry.covidInfo.isEmpty) {
            VStack(spacing: 0) {
                TitleDateHeader(title: entry.countryInfo.code.flag + " " + entry.countryInfo.display_name, date: entry.date)
                    .padding(.vertical, 4)
                    .padding(.horizontal)
                CaseStatGrid(entry: entry)
            }

        } else {
            VStack(alignment: .leading) {
                Text("No info for this country")
                    .bold()
                    .foregroundColor(.orange)
                    .font(.title)
            }.font(.title3)
        }

    }
}

//struct StatsWidgetMedium_Previews: PreviewProvider {
//    static var previews: some View {
//
//        let covidCases = CovidCases(new: "105475420", active: 2, critical: 3, recovered: 5, total: 60)
//        let covidDeaths = CovidDeaths(new: "400", total: 200)
//        let covidInfo = [CovidCountry(continent: "us", country: "us", cases: covidCases, deaths: covidDeaths, time: "")]
//        let covidEntry = CovidEntry(date: Date(), covidInfo: covidInfo)
//
//
//        StatsWidgetMedium(entry: covidEntry)
//            .previewContext(WidgetPreviewContext(family: .systemMedium))
//    }
//}
