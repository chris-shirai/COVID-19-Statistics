//
//  Utils.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 8/4/22.
//

import Foundation

extension CountryType {
    convenience init(country: SingleCountryIdentityData){
        self.init(identifier: country.api_name, display: country.display_name)
    }
}
