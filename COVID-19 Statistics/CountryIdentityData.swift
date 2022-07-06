//
//  CountryData.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 7/4/22.
//

import Foundation

// These structs are used for JSON parsing from the local countriesData file
struct CountryIdentityData: Codable, Hashable {
    let countries: [SingleCountryIdentityData]
}

struct SingleCountryIdentityData: Codable, Hashable {
    let api_name: String // used to fetch data from api
    let display_name: String
    let code: String // for png image of flag
}
