//
//  ForecastView.swift
//  itsWeather
//
//  Created by Christopher Koski on 4/28/22.
//

import SwiftUI

struct ForecastView: View {
  @StateObject var weatherAPI: WeatherAPI
  
  var body: some View {
    
    ScrollView(.horizontal, showsIndicators: false) {
      ForecastCellScrollStack(weatherAPI: weatherAPI)
    }
    
    .padding(.all, 20)
    .frame(maxWidth: .infinity)
    .thinMaterialBackground()
    
    //    .strokeStyle()
    .customShadow()
    .padding(.leading)
    .padding(.trailing)
    
  }
}

struct ForecastCellView: View {
  var day: String?
  var highTemp: Int?
  var lowTemp: Int?
  var condition: String?
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(day ?? "Monday")
        .font(.caption2.bold())
      Image(systemName: condition ?? "cloud")
        .resizable()
        .scaledToFit()
        .frame(width: 40, height: 40)
      HStack(spacing: 2) {
        Text("H")
          .font(.caption2)
          .frame(width: 10)
        Text(":")
          .font(.caption2)
        Text("\(highTemp ?? 90)")
          .font(.caption2)
      }
      HStack(spacing: 2) {
        Text("L")
          .font(.caption2)
          .frame(width: 10)
        Text(":")
          .font(.caption2)
        Text("\(lowTemp ?? 80)")
          .font(.caption2)
      }
    }
  }
}

struct ForecastCellScrollStack: View {
  @StateObject var weatherAPI: WeatherAPI
  var body: some View {
    HStack(spacing: 13) {
      ForEach(weatherAPI.forecasts, id: \.self) { forecast in
        
        let date = Date(timeIntervalSince1970: TimeInterval(forecast.dt))
        
        ForecastCellView(
          day: date.dayOfWeek(),
          highTemp: Int(forecast.temp.max),
          lowTemp: Int(forecast.temp.min),
          condition: weatherAPI.convertToConditionString(from: forecast.weather[0].id)
        )
      }
    }
  }
}

struct ForecastView_Previews: PreviewProvider {
  static var weatherAPI = WeatherAPI()
  static var previews: some View {
    ForecastView(weatherAPI: weatherAPI)
  }
}
