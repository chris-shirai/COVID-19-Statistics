//
//  CovidWidgetView.swift
//  HelloWidgetExtension
//
//  Created by DevTechie on 1/3/22.
//

import SwiftUI
import WidgetKit

struct StatsWidgetSmall: View {
    
    let entry: CovidEntry

    var body: some View {

            if(!entry.covidInfo.isEmpty) {
                
                let newCases = entry.covidInfo[0].cases.new != nil ? UIHelper.formatPosNegNumber(countString: entry.covidInfo[0].cases.new!) : "--"
                let activeCases = entry.covidInfo[0].cases.active != nil ? UIHelper.formatNumber(int: entry.covidInfo[0].cases.active!) : "--"
                let newDeaths = entry.covidInfo[0].deaths.new != nil ? UIHelper.formatPosNegNumber(countString: String(entry.covidInfo[0].deaths.new!)) : "--"

                
                VStack(spacing: 0){
                    TitleDateHeader(title: entry.countryInfo.code.flag + " " + entry.countryInfo.code, date: entry.date)
                        .padding(.vertical, 4)
                        .padding(.horizontal)
                    
                    CasesStatView(text: "New cases", totalCountText: newCases, color: peachColor)
                    CasesStatView(text: "Active cases", totalCountText: activeCases, color: blueColor)
                    CasesStatView(text: "New deaths", totalCountText: newDeaths, color: orangeColor)
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

//struct ContentView_Previews: PreviewProvider {
//
//    let covidCases = CovidCases(total: 19)
//    let covidDeaths = CovidDeaths(total: 12)
//
//    static var previews: some View {
//
//        let covidCases = CovidCases(new: "107653560", active: 2, critical: 3, recovered: 5, total: 60)
//        let covidDeaths = CovidDeaths(new: "876576100", total: 200)
//        let covidInfo = [CovidCountry(continent: "us", country: "us", cases: covidCases, deaths: covidDeaths, time: "")]
//        let covidEntry = CovidEntry(date: Date(), covidInfo: covidInfo)
//
//
//        StatsWidgetSmall(entry: covidEntry)
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
