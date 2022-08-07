//
//  CaseStatGrid.swift
//  HelloWidgetExtension
//
//  Created by Chris Loreta on 7/26/22.
//

import SwiftUI
import WidgetKit

struct CaseStatGrid: View {

    let entry: CovidEntry

//    let totalCount: Total
    let columns: [GridItem] = [
            .init(.flexible(), spacing: 0),
            .init(.flexible(), spacing: 0)
    ]
    var body: some View {


        if(!entry.covidInfo.isEmpty) {
            let newCases = entry.covidInfo[0].cases.new != nil ? UIHelper.formatPosNegNumber(countString: entry.covidInfo[0].cases.new!) : "--"
            let activeCases = entry.covidInfo[0].cases.active != nil ? UIHelper.formatNumber(int: entry.covidInfo[0].cases.active!) : "--"
            let newDeaths = entry.covidInfo[0].deaths.new != nil ? UIHelper.formatPosNegNumber(countString: String(entry.covidInfo[0].deaths.new!)) : "--"
            let totalDeaths = UIHelper.formatNumber(int: entry.covidInfo[0].deaths.total) // non-optional


            VStack {
                GeometryReader { proxy in
                    LazyVGrid(columns: columns, spacing: 0) {
                        CasesStatView(text: "New cases", totalCountText: newCases, color: peachColor, height: proxy.size.height / 2)
                        CasesStatView(text: "Active cases", totalCountText: activeCases, color: blueColor, height: proxy.size.height / 2)
                        CasesStatView(text: "New deaths", totalCountText: newDeaths, color: orangeColor, height: proxy.size.height / 2)
                        CasesStatView(text: "Total deaths", totalCountText: totalDeaths, color: purpleColor, height: proxy.size.height / 2)
                    }
                }
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

//struct CaseStatGrid_Previews: PreviewProvider {
//    static var previews: some View {
//
//        let covidCases = CovidCases(new: "+10668526540", active: 27642541, critical: 3, recovered: 5, total: 60)
//        let covidDeaths = CovidDeaths(new: "+176556400", total: 207652560)
//        let covidInfo = [CovidCountry(continent: "us", country: "us", cases: covidCases, deaths: covidDeaths, time: "")]
//        let covidEntry = CovidEntry(date: Date(), covidInfo: covidInfo)
//
//        CaseStatGrid(entry: covidEntry)
//            .previewContext((WidgetPreviewContext(family: .systemMedium)))
//    }
//}
