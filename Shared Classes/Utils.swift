//
//  Utils.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 8/4/22.
//

import Foundation

extension String {
    
    var flag: String {
        let base : UInt32 = 127397
        var s = ""
        for v in unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
}

extension CountryType {
    convenience init(country: SingleCountryIdentityData){
        self.init(identifier: country.api_name, display: country.display_name)
    }
}
