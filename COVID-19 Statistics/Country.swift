//
//  Country.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 6/30/22.
//

import Foundation

struct Country: Codable{
    var get: String
    var response: [Placeholder]
}

struct Placeholder: Codable {
    var continent: String
    var country: String
    var population: Int
    
}
