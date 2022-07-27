//
//  WeatherService.swift
//  HelloWidgetExtension
//
//  Created by DevTechie on 1/3/22.
//

import Foundation

class WeatherService {
    let url = URL(string: "https://api.lil.software/weather?latitude=37.7569385&longitude=-122.4733143")!
    
    func getWeather(completion: @escaping (Result<[Weather], Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            completion(.success(self.getWeatherResponse(fromData: data!)))
        }.resume()
    }
    
    private func getWeatherResponse(fromData data: Data) -> [Weather] {
        let weatherData = try? JSONDecoder().decode(WeatherResponse.self, from: data)
        
        if let weather = weatherData {
            return weather.forecast
        }
        
        return [Weather(name: "Error", temperature: 0, unit: "", description: "Error")]
    }
}
