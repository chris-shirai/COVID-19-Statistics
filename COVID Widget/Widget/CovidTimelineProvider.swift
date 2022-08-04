//
//  CovidTimelineProvider.swift
//  HelloWidgetExtension
//
//  Created by Chris Loreta on 7/25/22.
//

import WidgetKit

struct CovidTimelineProvider: IntentTimelineProvider {
    typealias Entry = CovidEntry
    
    private func snapshotCovidInfo() -> [CovidCountry] {
        var weatherInfo = [CovidCountry]()
        for i in 0...9 {
            
            let covidCases = CovidCases(total: i)
            let covidDeaths = CovidDeaths(total: i)
            let covid = CovidCountry(continent: "us", country: "us", cases: covidCases, deaths: covidDeaths, time: "")
            weatherInfo.append(covid)
        }
        return weatherInfo
    }
    
    func placeholder(in context: Context) -> CovidEntry {
        CovidEntry(date: Date(), covidInfo: snapshotCovidInfo())
    }
    
    func getSnapshot(for configuration: ShowCovidDataIntent, in context: Context, completion: @escaping (CovidEntry) -> Void) {
        completion(CovidEntry(date: Date(), covidInfo: snapshotCovidInfo()))
    }
    
    func getTimeline(for configuration: ShowCovidDataIntent, in context: Context, completion: @escaping (Timeline<CovidEntry>) -> Void) {
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
        
        NetworkManager().getCountryCovidData(for: configuration.country!.identifier!) { result in
            let covidInfo: [CovidCountry]
            
            switch result {
            case .success(let fetchedCovid):
                covidInfo = fetchedCovid.response
                
            case .failure(let err):
                
                let covidCases = CovidCases(total: 19)
                let covidDeaths = CovidDeaths(total: 12)
                
                covidInfo = [CovidCountry(continent: "us", country: "us", cases: covidCases, deaths: covidDeaths, time: "")]
            }
            
            let entry = CovidEntry(date: currentDate, covidInfo: covidInfo)
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
            
            completion(timeline)
        }
    }
}
