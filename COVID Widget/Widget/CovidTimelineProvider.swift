//
//  CovidTimelineProvider.swift
//  HelloWidgetExtension
//
//  Created by Chris Loreta on 7/25/22.
//

import WidgetKit

struct CovidTimelineProvider: IntentTimelineProvider {
    typealias Entry = CovidEntry
    
    var sampleCountryInfo = SingleCountryIdentityData(api_name: "USA", display_name: "United States of America", code: "US")
    
    let countryManager = CountryManager()

    
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
        CovidEntry(date: Date(), covidInfo: snapshotCovidInfo(), countryInfo: sampleCountryInfo)
    }
    
    func getSnapshot(for configuration: ShowCovidDataIntent, in context: Context, completion: @escaping (CovidEntry) -> Void) {
        completion(CovidEntry(date: Date(), covidInfo: snapshotCovidInfo(), countryInfo: sampleCountryInfo))
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
                
                covidInfo = [CovidCountry(continent: "US", country: "US", cases: covidCases, deaths: covidDeaths, time: "")]
            }
            
            // Get the identity data for the country the user chose in the widget configuration
            var countryList: [SingleCountryIdentityData] = []
            
            let data = countryManager.readJSONFromFile(fileName: "countriesData")
            if let safeData = data {
                let sortedSafeData = safeData.sorted(by: { $0.display_name < $1.display_name })
                countryList = sortedSafeData
            }
            
            let entry = CovidEntry(date: currentDate, covidInfo: covidInfo, countryInfo: countryList.first{ $0.api_name == configuration.country!.identifier} ?? sampleCountryInfo)
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
            
            completion(timeline)
        }
    }
}
