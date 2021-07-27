//
//  File.swift
//  Clima
//
//  Created by 신소민 on 2021/07/25.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weather: WeatherModel)
    func didFailWithError(_ error: Error)
}

struct WeatherManager {
    
    var weatherURL: String {
        return "https://api.openweathermap.org/data/2.5/weather?appid=\(getApiKey())&units=metric"
    }
    
    var delegate: WeatherManagerDelegate?
    
    // MARK: - Methods
    
    func getApiKey() -> String {
        guard let filePath = Bundle.main.path(forResource: "keys", ofType: "plist") else {
            print("Couldn't find file 'keys.plist'")
            return ""
        }
        
        let plist = NSDictionary(contentsOf: URL(fileURLWithPath: filePath))
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            print("Couldn't find key 'API_KEY in 'keys.plist'")
            return ""
        }
        return value
    }
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: Double, longitude: Double) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        // 1. Create a URL
        if let url = URL(string: urlString) {
            
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                if let data = data {
                    if let weather = self.parseJSON(data) {
                        self.delegate?.didUpdateWeather(weather)
                    }
                }
            }
            
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData: WeatherData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            let desc = decodedData.weather[0].description

            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp, description: desc)
            return weather
            
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}
