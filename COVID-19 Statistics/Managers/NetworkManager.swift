//
//  NetworkManager.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 6/30/22.
//

import Foundation

class NetworkManager {


    func getCountryCovidData(countryApiName: String){
        
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
                } catch {
                    print(error)
                }

            }
        })

        dataTask.resume()
    }


}






