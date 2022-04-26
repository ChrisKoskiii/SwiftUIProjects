//
//  ForecastModel.swift
//  Weatha
//
//  Created by Christopher Koski on 3/29/22.
//

//   let forecast = try? newJSONDecoder().decode(Forecast.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Forecast: Codable {
  let city: City
  let cod: String
  let message: Double
  let cnt: Int
  let list: [List]
}

// MARK: - City
struct City: Codable {
  let id: Int
  let name: String
  let coord: Coord
  let country: String
  let population, timezone: Int
}

// MARK: - Coord
struct Coord: Codable {
  let lon, lat: Double
}

// MARK: - List
struct List: Codable, Hashable {
  static func == (lhs: List, rhs: List) -> Bool {
    return lhs.temp == rhs.temp && lhs.feelsLike == rhs.feelsLike
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(temp)
    hasher.combine(feelsLike)
  }
  
  let dt, sunrise, sunset: Int
  let temp: Temp
  let feelsLike: FeelsLike
  let pressure, humidity: Int
  let weather: [Weather]
  let speed: Double
  let deg: Int
  let gust: Double
  let clouds: Int
  let pop: Double
  let rain: Double?
  
  
  enum CodingKeys: String, CodingKey {
      case dt, sunrise, sunset, temp
      case feelsLike = "feels_like"
      case pressure, humidity, weather, speed, deg, gust, clouds, pop, rain
  }
}

// MARK: - FeelsLike
struct FeelsLike: Codable, Hashable {
  let day, night, eve, morn: Double
}

// MARK: - Temp
struct Temp: Codable, Hashable {
  let day, min, max, night: Double
  let eve, morn: Double
}



