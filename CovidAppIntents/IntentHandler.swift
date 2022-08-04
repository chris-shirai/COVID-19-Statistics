//
//  IntentHandler.swift
//  CovidAppIntents
//
//  Created by Chris Loreta on 8/3/22.
//

import Intents

class IntentHandler: INExtension, ShowCovidDataIntentHandling {
    
    func provideCountryOptionsCollection(for intent: ShowCovidDataIntent, with completion: @escaping (INObjectCollection<CountryType>?, Error?) -> Void) {

//        let c =             CountryType(identifier: "USA", display: "United States of America");
//        c.countryob

        let countries: [CountryType] = [
            CountryType(identifier: "USA", display: "United States of America"),
            CountryType(identifier: "UK", display: "United Kingdom")
        ]
        
        // Create a collection with the array of characters.
        let collection = INObjectCollection(items: countries)

        // Call the completion handler, passing the collection.
        completion(collection, nil)
    }
    
}
