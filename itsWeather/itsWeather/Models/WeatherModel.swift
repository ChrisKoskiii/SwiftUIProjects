//
//  WeatherModel.swift
//  itsWeather
//
//  Created by Christopher Koski on 4/30/22.
//

import Foundation

struct WeatherModel: Codable {
  var weather: [Weather]
  var main: Main
  var name: String
}

struct Weather: Codable {
  var id: Int
  var main: String
  var description: String
}

struct Main: Codable {
  var temp: Double
  var temp_min: Double
  var temp_max: Double
  var humidity: Int
}
