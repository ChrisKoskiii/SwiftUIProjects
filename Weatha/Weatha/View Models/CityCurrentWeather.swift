//
//  CityCurrentWeather.swift
//  Weatha
//
//  Created by Christopher Koski on 4/5/22.
//

import Foundation


class CityCurrentWeather {
  
var cityURLString = "https://api.openweathermap.org/geo/1.0/direct?limit=5&appid=2e22b2e5420de2d5f7a7d1a713555439&units=imperial"
  
  func fetchCurrentWeather(cityName: String) {
    let urlString = "\(cityURLString)&q=\(cityName)"
    print(urlString)
    requestData(from: urlString)
  }
  
  func requestData(from url: String) {
    guard let url = URL(string: url) else {
      print("No URL Found")
      return
    }
    URLSession.shared.dataTask(with: url) { data, response, error in
      do {
        if let safeData = try JSONDecoder().decode(WeatherModel?.self, from: data!) {
          let weather = safeData
          DispatchQueue.main.async {
            
            print("Success")
            print(weather.name)
          }
        }
      } catch {
        print("Failed fetching current weather data, \(error)")
      }
    }
    .resume()
  }
}
