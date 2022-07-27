//
//  CovidWidgetView.swift
//  HelloWidgetExtension
//
//  Created by DevTechie on 1/3/22.
//

import SwiftUI

struct CovidView: View {
    let covid: Covid
    let updatedDate: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("San Francisco")
            Text("test\(String(covid.cases.total))")
                .font(.largeTitle)
//            Text(CovidUtils.getCovidIcon(covid.description))
//                .padding(.top, 10)
//            Text(covid.description)
//                .font(.footnote)
            
            HStack {
                Spacer()
                Text("Update: \(updatedDate.timeOnly())")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
        }.padding()
    }
}

//struct DailyCovidView: View {
//    let covid: Covid
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text(covid.name.lowercased().contains("night") ? "\(covid.name.prefix(2)) 🌙" : covid.name.prefix(2))
//
//            Text("\(covid.temperature)°\(covid.unit)")
//
//            Text(CovidUtils.getCovidIcon(covid.description))
//                .padding(.top, 10)
//        }.padding()
//    }
//}

struct CovidEntryView: View {
    let entry: CovidEntry
    
    @Environment(\.widgetFamily) var family
    
    let baseColor = Color.gray.opacity(0.2)
    let darkColor = Color.black.opacity(0.8)
    
    var body: some View {
        switch family {
        case .systemSmall:
            
            if(!entry.covidInfo.isEmpty){
                ZStack {
                         baseColor
                         CovidView(covid: entry.covidInfo[0], updatedDate: entry.date)
                     }.edgesIgnoringSafeArea(.all)
            } else{
                VStack(alignment: .leading) {
                    Text("GOODBYE")
                    Text("DevTechie!")
                        .bold()
                        .foregroundColor(.orange)
                        .font(.title)
                }.font(.title3)
            }
            
            
            
     
            
        case .systemMedium:
            if(!entry.covidInfo.isEmpty){
                ZStack {
                         baseColor
                         CovidView(covid: entry.covidInfo[0], updatedDate: entry.date)
                     }.edgesIgnoringSafeArea(.all)
            } else{
                VStack(alignment: .leading) {
                    Text("HELLO")
                    Text("DevTechie!")
                        .bold()
                        .foregroundColor(.orange)
                        .font(.title)
                }.font(.title3)
            }
//
//        case .systemLarge:
//            VStack {
//                ZStack {
//                    HStack(spacing: 0) {
//                        Rectangle().fill(baseColor)
//                        Rectangle().fill(darkColor)
//                    }
//                    HStack {
//                        CovidView(covid: entry.covidInfo[0], updatedDate: entry.date)
//                        CovidView(covid: entry.covidInfo[1], updatedDate: entry.date)
//                            .foregroundColor(.white)
//                    }
//                }
//                VStack {
//                    HStack {
//                        VStack(alignment: .leading) {
//                            DailyCovidView(covid: entry.covidInfo[2])
//                            DailyCovidView(covid: entry.covidInfo[3])
//                        }
//
//                        VStack(alignment: .leading) {
//                            DailyCovidView(covid: entry.covidInfo[4])
//                            DailyCovidView(covid: entry.covidInfo[5])
//                        }
//
//                        VStack(alignment: .leading) {
//                            DailyCovidView(covid: entry.covidInfo[6])
//                            DailyCovidView(covid: entry.covidInfo[7])
//                        }
//
//                        VStack(alignment: .leading) {
//                            DailyCovidView(covid: entry.covidInfo[8])
//                            DailyCovidView(covid: entry.covidInfo[9])
//                        }
//                    }
//                }
//            }
            
        default:
            ZStack {
                baseColor
                CovidView(covid: entry.covidInfo[0], updatedDate: entry.date)
            }.edgesIgnoringSafeArea(.all)
        }
    }
}
