//
//  UIHelper.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 7/5/22.
//

import UIKit

// This class contains functions that help design the UI
struct UIHelper{
    
    // Used in the searchable country list
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
    
    // Calculates the height of covid info cards
    static func calculateCovidInfoCardHeight(in view: UIView, headerHeight: CGFloat) -> CGFloat{
        let height = view.bounds.height
        
        let itemHeight = (height - headerHeight) / 6 // simple trial and error
        return itemHeight
    }
    
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
