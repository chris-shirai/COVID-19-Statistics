//
//  Constants.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 7/30/22.
//

import UIKit

import Foundation

struct Constants{
    static let flagWidthHeightRatio: CGFloat = 0.67
}

// Error list
enum GFError: String, Error {
    case invalidUsername    = "This username created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
    case unableToFavorite   = "There was an error favoriting this user. Please try again."
    case alreadyInFavorites = "You've already favorited this user. You must REALLY like them!"

}
