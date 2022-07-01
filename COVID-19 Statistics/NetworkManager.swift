//
//  NetworkManager.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 6/30/22.
//

import Foundation

class NetworkManager {


    func getData(){
        
        let headers = [
            "X-RapidAPI-Key": "be51638368msh5ee92e7dfdb19b8p15c7c3jsn9e93c6d92cdc",
            "X-RapidAPI-Host": "covid-193.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://covid-193.p.rapidapi.com/history?country=usa&day=2020-06-02")! as URL,
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
                    let followers = try decoder.decode(Country.self, from: data!)
                    var a = 1
                } catch {
                    var a = 2
                }






                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
        })

        dataTask.resume()
    }


}






