//
//  WeatherModel.swift
//  Weatha
//
//  Created by Christopher Koski on 3/27/22.
//

import Foundation

struct WeatherModel: Codable {
  var name: String
  var main: Main
  var weather: [Weather]
}

struct Main: Codable {
  var temp: Double
}

struct Weather: Codable {
    let id: Int

}
