//
//  QuoteService.swift
//  HelloWidgetExtension
//
//  Created by DevTechie on 1/2/22.
//

import Foundation

struct QuoteService {
    func getRandomQuote(completion: @escaping (Result<Quote, Error>) -> Void) {
        let url = URL(string: "https://api.forismatic.com/api/1.0/?method=getQuote&format=json&lang=en")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let data = data,
                  let quote = try? JSONDecoder().decode(Quote.self, from: data) else {
                      return
                  }
            
            completion(.success(quote))
        }.resume()
    }
}
