//
//  WeatherManager.swift
//  Weatha
//
//  Created by Christopher Koski on 3/27/22.
//

import Foundation
import CoreLocation
import MapKit

class CurrentWeatherManager: ObservableObject {
  @Published var city = "- - -"
  @Published var temp = 0
  @Published var conditionString = "cloud"
  
  let currentWeatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=2e22b2e5420de2d5f7a7d1a713555439&units=imperial"
  let forecastURL = "https://api.openweathermap.org/data/2.5/forecast/daily?appid=2e22b2e5420de2d5f7a7d1a713555439&units=imperial"
  
  //current weather API call URL
  func fetchCurrentWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) {
    let urlString = "\(currentWeatherURL)&lat=\(lat)&lon=\(lon)"
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
            self.city = weather.name
            self.temp = Int(weather.main.temp)
            
            //converts our weather ID to a string from the switch statement function
            self.conditionString = self.convertToConditionString(from: weather.weather[0].id)
            
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
  
  func convertToConditionString(from id: Int) -> String {
    var conditionString: String {
      switch id {
      case 200...232:
        return "cloud.bolt.rain"
      case 300...321:
        return "cloud.drizzle"
      case 500...531:
        return "cloud.rain"
      case 600...622:
        return "cloud.snow"
      case 701...781:
        return "cloud.fog"
      case 800:
        return "sun.max"
      case 801...804:
        return "cloud"
      default:
        return "cloud"
      }
    }
    return conditionString
  }
}

