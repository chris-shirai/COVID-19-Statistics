//
//  NetworkManager.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 6/30/22.
//

import Foundation

// placeholder
enum GFError: String, Error {
    case invalidUsername    = "This username created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
    case unableToFavorite   = "There was an error favoriting this user. Please try again."
    case alreadyInFavorites = "You've already favorited this user. You must REALLY like them!"
}


class NetworkManager {

    static let shared = NetworkManager()

    func getCountryCovidData(for countryApiName: String, completed: @escaping (Result<CountryCovidData, GFError>) -> Void ) {
        
        let headers = [
            "X-RapidAPI-Key": "fb5804030bmsh7c6fffd85aede06p1a96b1jsn43001f58bb60",
            "X-RapidAPI-Host": "covid-193.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://covid-193.p.rapidapi.com/history?country=\(countryApiName)&day=2020-06-02")! as URL,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let followers = try decoder.decode(CountryCovidData.self, from: data!)
                    print(followers)

                    completed(.success(followers))
                } catch {
                    completed(.failure(.invalidData))
//                    print(error)
                }

            }
        })

        dataTask.resume()
    }


}






