//
//  ForecastModel.swift
//  itsWeather
//
//  Created by Christopher Koski on 5/1/22.
//

import Foundation

struct ForecastModel: Codable {
    let city: City
}

struct City: Codable {
    let id: Int
    let name: String
    let country: String
    let population, timezone: Int
}
