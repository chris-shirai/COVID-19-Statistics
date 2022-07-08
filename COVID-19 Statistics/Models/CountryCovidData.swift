//
//  Country.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 6/30/22.
//

import Foundation

struct CountryCovidData: Codable{
    var get: String?
    var response: [Placeholder]
}

struct Placeholder: Codable {
    var continent: String
    var country: String
    var population: Int
    let cases: CovidCases
    
}

struct CovidCases: Codable {
    var new: String?
    let active: Int
    let critical: Int
    let recovered: Int
    let total: Int
}
