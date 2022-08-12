//
//  IntentHandler.swift
//  CovidAppIntents
//
//  Created by Chris Loreta on 8/3/22.
//

import Foundation

import Intents

class IntentHandler: INExtension, ShowCovidDataIntentHandling {
    
    func provideCountryOptionsCollection(for intent: ShowCovidDataIntent, with completion: @escaping (INObjectCollection<CountryType>?, Error?) -> Void) {
        
        let countryManager = CountryManager()
        var countryList: [SingleCountryIdentityData] = []

        let data = countryManager.readJSONFromFile(fileName: "countriesData")
        if let safeData = data {
            let sortedSafeData = safeData.sorted(by: { $0.display_name < $1.display_name })
            countryList = sortedSafeData
        }
        
        let countryParams = countryList.map {CountryType(country: $0)}

        completion(INObjectCollection( items: countryParams), nil)
    }
    
    func defaultCountry(for intent: ShowCovidDataIntent) -> CountryType? {
        return CountryType(identifier: "USA", display: "United States of America")
    }
    
}
