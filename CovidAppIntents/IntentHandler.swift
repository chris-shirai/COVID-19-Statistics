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

        
//        let ctries = countryManager.getCountryList()
//
//        let countryParams = ctries.map {CountryType(country: $0)}
//
//        completion(INObjectCollection(sections: [INObjectSection(title: "Countries", items: countryParams)])
//                   , nil)
        
        
        let data = countryManager.readJSONFromFile(fileName: "countriesData")
        if let safeData = data {
            let sortedSafeData = safeData.sorted(by: { $0.display_name < $1.display_name })
            countryList = sortedSafeData
        }
        
        let countryParams = countryList.map {CountryType(country: $0)}

        completion(INObjectCollection( items: countryParams), nil)
        

        
        
        let countries: [CountryType] = [
            CountryType(identifier: "USA", display: "United States of America"),
            CountryType(identifier: "UK", display: "United Kingdom")
        ]
        
        // Create a collection with the array of characters.
        let collection = INObjectCollection(items: countries)

        // Call the completion handler, passing the collection.
//        completion(collection, nil)
    }
    
}
