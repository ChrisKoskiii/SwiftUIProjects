//
//  File.swift
//  Weatha
//
//  Created by Christopher Koski on 3/29/22.
//

import Foundation
import CoreLocation
import MapKit

class ForecastManager: ObservableObject {
  
  @Published var minTemp: Int?
  @Published var maxTemp: Int?
  @Published var listArray: [List] = []
  
  let forecastURL = "https://api.openweathermap.org/data/2.5/forecast/daily?appid=2e22b2e5420de2d5f7a7d1a713555439&units=imperial"
  
  //forecast API call URL
  func fetchForecast(lat: CLLocationDegrees, lon: CLLocationDegrees) {
    let urlString = "\(forecastURL)&lat=\(lat)&lon=\(lon)"
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
        if let safeData = try JSONDecoder().decode(Forecast?.self, from: data!) {
          let forecast = safeData
          DispatchQueue.main.async { 
            print(forecast.list[0].temp.min)
            print(forecast.list[0].temp.max)
            self.listArray = forecast.list
            print(self.listArray.count)
            print(self.listArray)
            
            
            
            
//            self.dayArray.append(DateConversion().convertDate(from: forecast.list[0].dt))
//            self.dayArray.append(DateConversion().convertDate(from: forecast.list[1].dt))
//            self.dayArray.append(DateConversion().convertDate(from: forecast.list[2].dt))
//            self.dayArray.append(DateConversion().convertDate(from: forecast.list[3].dt))
//            self.dayArray.append(DateConversion().convertDate(from: forecast.list[4].dt))
//            self.dayArray.append(DateConversion().convertDate(from: forecast.list[5].dt))
//            self.dayArray.append(DateConversion().convertDate(from: forecast.list[6].dt))
//            print(self.dayArray)
          }
        }
      } catch {
        print("Failed fetching forecast data, \(error)")
      }
    }
    .resume()
  }
}

