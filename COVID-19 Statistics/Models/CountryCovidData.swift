//
//  Country.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 6/30/22.
//

import Foundation

// This is modeled after the data coming from the web API
struct CountryCovidData: Codable{
    var response: [Response]
}

struct Response: Codable {
    var continent: String
    var country: String
    var population: Int?
    var cases: CovidCases
    var deaths: CovidDeaths
    var time: String
}

struct CovidCases: Codable {
    var new: String?
    var active: Int?
    var critical: Int?
    var recovered: Int?
    var total: Int
}

struct CovidDeaths: Codable {
    var new: String?
    var total: Int
}
