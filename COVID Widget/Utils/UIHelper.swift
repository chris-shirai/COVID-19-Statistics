//
//  UIHelper.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 7/27/22.
//

import UIKit

struct UIHelper{
    
    // Takes in an unformatted number and returns the number with commas to separate thousands
    static func formatNumber(int: Int) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let formattedNumber = numberFormatter.string(from: NSNumber(value: int)) else { return "n/a" }
        return formattedNumber
    }
    
    // Same as formatNumber, but accepts a string of count with prefix of '+'
    static func formatPosNegNumber(countString: String) -> String {
        
        var newString = countString
        
        if(countString.starts(with: "+")){
            newString.removeFirst()
            newString = formatNumber(int: Int(newString)!) // convert to int and add commas
        }
        
        return newString
    }
}
