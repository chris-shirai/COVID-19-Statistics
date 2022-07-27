//
//  Weather.swift
//  HelloWidgetExtension
//
//  Created by DevTechie on 1/3/22.
//

import Foundation

struct Weather: Codable {
    let name: String
    let temperature: Int
    let unit: String
    let description: String
}

struct WeatherResponse: Codable {
    let forecast: [Weather]
}
