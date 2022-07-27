//
//  CovidTimelineProvider.swift
//  HelloWidgetExtension
//
//  Created by Chris Loreta on 7/25/22.
//

import WidgetKit

struct CovidTimelineProvider: TimelineProvider {
    typealias Entry = CovidEntry

    private func snapshotCovidInfo() -> [Covid] {
        var weatherInfo = [Covid]()
        for i in 0...9 {
            
            
            let covidCases = CovidCases(total: i)
            let covidDeaths = CovidDeaths(total: i)
            
//            covidInfo = [Response(continent: "us", country: "us", cases: covidCases, deaths: covidDeaths, time: "")]
            
            
            
            let covid = Covid(continent: "us", country: "us", cases: covidCases, deaths: covidDeaths, time: "")
            weatherInfo.append(covid)
        }
        return weatherInfo
    }
    
    func placeholder(in context: Context) -> CovidEntry {
        CovidEntry(date: Date(), covidInfo: snapshotCovidInfo())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (CovidEntry) -> Void) {
        completion(CovidEntry(date: Date(), covidInfo: snapshotCovidInfo()))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<CovidEntry>) -> Void) {
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
        
        CovidService().getCountryCovidData(for: "USA") { result in
            let covidInfo: [Covid]
            
            switch result {
            case .success(let fetchedCovid):
                covidInfo = fetchedCovid
                
//                let covidCases: [CovidCases] = []
//                let covidDeaths: [CovidDeaths] = []
                
            case .failure(let err):
                
                let covidCases = CovidCases(total: 19)
                let covidDeaths = CovidDeaths(total: 12)
                
                covidInfo = [Covid(continent: "us", country: "us", cases: covidCases, deaths: covidDeaths, time: "")]
            }
            
            let entry = CovidEntry(date: currentDate, covidInfo: covidInfo)
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
            
            completion(timeline)
        }
    }
}
