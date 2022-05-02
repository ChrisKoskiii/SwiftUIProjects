//
//  WeatherAPI.swift
//  itsWeather
//
//  Created by Christopher Koski on 4/30/22.
//

import Foundation
import CoreLocation

class WeatherAPI: ObservableObject {
  //Current weather
  @Published var cityName: String? = ""
  @Published var currentTemp: Int? = 0
  @Published var humidity: Int? = 0
  @Published var minTemp: Int? = 0
  @Published var maxTemp: Int? = 0
  @Published var condition: String = "cloud"
  @Published var description: String? = ""
  
  //Forecase
  @Published var forecasts: [List] = []
  
  var weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=2e22b2e5420de2d5f7a7d1a713555439&units=imperial"
  var forecastURL = "https://api.openweathermap.org/data/2.5/forecast/daily?appid=2e22b2e5420de2d5f7a7d1a713555439&units=imperial"
  
  func fetchCurrentWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) {
    let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
    print(urlString)
    requestCurrentData(from: urlString)
  }
  func fetchForecast(lat: CLLocationDegrees, lon:CLLocationDegrees) {
    let urlString = "\(forecastURL)&lat=\(lat)&lon=\(lon)"
    print(urlString)
    requestForecastData(from: urlString)
  }
  
  func requestCurrentData(from url: String) {
    guard let url = URL(string: url) else {
      print("Invalid URL")
      return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      do {
        if let myData = try JSONDecoder().decode(WeatherModel?.self, from: data!) {
          let weatherData = myData
          DispatchQueue.main.async {
            self.cityName = weatherData.name
            self.currentTemp = self.convertToInt(from: weatherData.main.temp)
            self.humidity = weatherData.main.humidity
            self.minTemp = self.convertToInt(from: weatherData.main.temp_min)
            self.maxTemp = self.convertToInt(from: weatherData.main.temp_max)
            self.condition = self.convertToConditionString(from: weatherData.weather[0].id)
            self.description = weatherData.weather[0].description
          }
        }
      } catch {
        print("Failed fetchign date, \(error)")
      }
    }.resume()
  }
  
  func requestForecastData(from url: String) {
    guard let url = URL(string: url) else {
      print("Invalid URL")
      return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      do {
        if let myData = try JSONDecoder().decode(ForecastModel?.self, from: data!) {
          let forecastData = myData
          DispatchQueue.main.async {
            print("Forecast Success")
            print(forecastData.city.name)
            self.forecasts = forecastData.list
          }
        }
      } catch {
        print("Failed fetching date, \(error)")
      }
    }.resume()
  }
  
  func convertToInt(from myNum: Double) -> Int {
    var myInt: Int
    myInt = Int(myNum)
    return myInt
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
