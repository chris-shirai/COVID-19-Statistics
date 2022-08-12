//
//  Constants.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 7/30/22.
//

import UIKit

import Foundation

struct Constants{
    // ratio of height to width for flags
    static let flagWidthHeightRatio: CGFloat = 0.67
}

// Error list
enum GFError: String, Error {
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
    case unableToFavorite   = "There was an error favoriting this country. Please try again."
    case alreadyInFavorites = "Item is already in favorites"

}
