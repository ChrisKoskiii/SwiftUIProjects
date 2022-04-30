//
//  WeatherAPI.swift
//  itsWeather
//
//  Created by Christopher Koski on 4/30/22.
//

import Foundation
import CoreLocation

class WeatherAPI: ObservableObject {
  @Published var cityName: String? = ""
  @Published var currentTemp: Double? = 0.0
  @Published var humidity: Int? = 0
  
  var urlWithKey = "https://api.openweathermap.org/data/2.5/weather?appid=2e22b2e5420de2d5f7a7d1a713555439&units=imperial"
  
  func fetchCurrentWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) {
    let urlString = "\(urlWithKey)&lat=\(lat)&lon=\(lon)"
    print(urlString)
    requestData(from: urlString)
  }
  
  func requestData(from url: String) {
    guard let url = URL(string: url) else {
      print("Invalid URL")
      return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      do {
        if let myData = try JSONDecoder().decode(WeatherModel?.self, from: data!) {
          let weatherData = myData
          DispatchQueue.main.async {
            print("Success")
            print(weatherData.name)
            self.cityName = weatherData.name
            self.currentTemp = weatherData.main.temp
          }
        }
      } catch {
        print("Failed fetchign date, \(error)")
      }
    }.resume()
  }
}
