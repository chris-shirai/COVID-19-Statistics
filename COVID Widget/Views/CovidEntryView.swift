//
//  CovidWidgetView.swift
//  HelloWidgetExtension
//
//  Created by DevTechie on 1/3/22.
//

import SwiftUI
import WidgetKit

struct CovidView: View {
    let covid: Covid
    let updatedDate: Date

    var body: some View {
        VStack(alignment: .leading) {
            Text("San Francisco")
            Text("test\(String(covid.cases.total))")
                .font(.largeTitle)


            HStack {
                Spacer()
                Text("Update: \(updatedDate.timeOnly())")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
        }.padding()
    }
}

struct CovidEntryView: View {
    let entry: CovidEntry

    @Environment(\.widgetFamily) var family

    let baseColor = Color.gray.opacity(0.2)
    let darkColor = Color.black.opacity(0.8)

    var body: some View {

            if(!entry.covidInfo.isEmpty) {
                
                let newCases = entry.covidInfo[0].cases.new != nil ? String(entry.covidInfo[0].cases.new!) : "--"
                let activeCases = entry.covidInfo[0].cases.active != nil ? String(entry.covidInfo[0].cases.active!) : "--"
                let newDeaths = entry.covidInfo[0].deaths.new != nil ? String(entry.covidInfo[0].deaths.new!) : "--"

                
                
                VStack(spacing: 0){
                    TitleDateHeader(title: "test", date: entry.date)
                        .padding(.vertical, 4)
                        .padding(.horizontal)
                    
                    CasesStatView(text: "New cases", totalCountText: newCases, color: confirmed)
                    CasesStatView(text: "Active cases", totalCountText: activeCases, color: sick)
                    CasesStatView(text: "New deaths", totalCountText: newDeaths, color: death)
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

struct ContentView_Previews: PreviewProvider {

    let covidCases = CovidCases(total: 19)
    let covidDeaths = CovidDeaths(total: 12)

    static var previews: some View {

        let currentDate = Date()
        
        let covidCases = CovidCases(new: "100", active: 2, critical: 3, recovered: 5, total: 60)
        let covidDeaths = CovidDeaths(new: "100", total: 200)
        let covidInfo = [Covid(continent: "us", country: "us", cases: covidCases, deaths: covidDeaths, time: "")]
        
        let covidEntry = CovidEntry(date: Date(), covidInfo: covidInfo)


        CovidEntryView(entry: covidEntry)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
