//
//  DailyView.swift
//  Weatha
//
//  Created by Christopher Koski on 3/26/22.
//

import SwiftUI

struct DailyView: View {
  @ObservedObject var locationManager: LocationManager
  @ObservedObject var forecastManager: ForecastManager
  @ObservedObject var currentWeatherManager: CurrentWeatherManager
  var forecastIssShowing = false
  var body: some View {
    ZStack {
      BackgroundGradient()
      TopToolBar(locationManager: locationManager, currentWeatherManager: currentWeatherManager, forecastManager: forecastManager)
      CellsView(forecastManager: forecastManager, currentWeatherManager: currentWeatherManager)
    }
    .tabItem {
      Label("Daily", systemImage: "calendar")
    }
  }
}

//
struct CellsView: View {
  @ObservedObject var forecastManager: ForecastManager
  @ObservedObject var currentWeatherManager: CurrentWeatherManager
  var body: some View {
    VStack {
      if !forecastManager.listArray.isEmpty{
        ForEach(1..<forecastManager.listArray.count) { i in
          ForecastCell(forecastManager: forecastManager, minTemp: Int(forecastManager.listArray[i].temp.min), maxTemp: Int(forecastManager.listArray[i].temp.max), dayOfWeek: DateConversion().convertDate(from: forecastManager.listArray[i].dt), conditionString: currentWeatherManager.convertToConditionString(from: forecastManager.listArray[i].weather[0].id))
        }
      } else {
        Text("Let us use your location")
      }
    }
  }
}


struct DailyView_Previews: PreviewProvider {
  static var forecastManager = ForecastManager()
  static var currentWeatherManager = CurrentWeatherManager()
  static var locationManager = LocationManager()
  static var previews: some View {
    DailyView(locationManager: locationManager, forecastManager: forecastManager, currentWeatherManager: currentWeatherManager)
  }
}


//View wont load unless we get locatoin first
