//
//  ForecastModel.swift
//  itsWeather
//
//  Created by Christopher Koski on 5/1/22.
//

import Foundation

struct Forecasts: Codable {
  var forecasts: [ForecastModel]
}
struct ForecastModel: Codable {
  let city: City
  let list: [List]
}

struct List: Codable, Hashable {
  
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

struct Temp: Codable, Hashable{
    let day, min, max, night: Double
    let eve, morn: Double
}

struct FeelsLike: Codable, Hashable {
    let day, night, eve, morn: Double
}

struct City: Codable {
  let id: Int
  let name: String
  let country: String
  let population, timezone: Int
}
