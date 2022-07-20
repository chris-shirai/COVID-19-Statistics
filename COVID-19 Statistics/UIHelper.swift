//
//  UIHelper.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 7/5/22.
//

import Foundation
import UIKit

struct UIHelper{
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 20)

        return flowLayout
    }
    
    static func formatNumber(int: Int) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let formattedNumber = numberFormatter.string(from: NSNumber(value: int)) else { return "n/a" }
        return formattedNumber
    }
    
    // Accepts string of count with prefix of either + or -
    static func formatPosNegNumber(countString: String) -> String {
        
        var newString = countString
        var firstChar: Character
        
        if(countString.starts(with: "+") || countString.starts(with: "-")){
            firstChar = countString.first! // take the first char symbol
            newString.removeFirst()
            newString = formatNumber(int: Int(newString)!) // convert to int and add commas
            newString = String(firstChar) + newString // add first char back
        }
        
        return newString
    }
}
