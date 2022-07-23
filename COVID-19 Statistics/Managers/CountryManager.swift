//
//  CountryManager.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 7/4/22.
//

import Foundation

struct CountryManager {

    var countryList: [SingleCountryIdentityData] = []

    mutating func initData() {
        // country and capital data from https://geographyfieldwork.com/WorldCapitalCities.htm
        let data = readJSONFromFile(fileName: "countriesData")

        if let safeData = data {
            let sortedSafeData = safeData.sorted(by: { $0.display_name < $1.display_name })
            countryList = sortedSafeData
        }
    }

    func getCountryList() -> [SingleCountryIdentityData] {
        return countryList
    }

    func readJSONFromFile(fileName: String) -> [SingleCountryIdentityData]? {
        var json: [SingleCountryIdentityData]?

        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)

                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(CountryIdentityData.self, from: data)

                    var countryIdentityData: [SingleCountryIdentityData] = []
                    for item in decodedData.countries {
                        countryIdentityData.append(SingleCountryIdentityData(api_name: item.api_name, display_name: item.display_name, code: item.code))
                    }

                    json = countryIdentityData

                } catch {
                    print(error)
                }
            } catch {
                print(error)
            }
        }

        return json
    }
}
