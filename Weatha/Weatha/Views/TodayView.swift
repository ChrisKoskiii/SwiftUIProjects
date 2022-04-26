//
//  ContentView.swift
//  Weatha
//
//  Created by Christopher Koski on 3/26/22.
//

import SwiftUI
import CoreLocation
import CoreLocationUI

struct TodayView: View {
  @ObservedObject var currentWeatherManager: CurrentWeatherManager
  @ObservedObject var locationManager: LocationManager
  @ObservedObject var forecastManager: ForecastManager
  var body: some View {
    ZStack {
      BackgroundGradient()
      TopToolBar(locationManager: locationManager, currentWeatherManager: currentWeatherManager, forecastManager: forecastManager)
      CenterWeatherView(locationManager: locationManager, weatherManager: currentWeatherManager)
    }
    .tabItem {
      Label("Today", systemImage: "sun.max")
    }
  }
  
  func getUserLocation() {
    locationManager.manager.requestWhenInUseAuthorization()
    print(locationManager.lastLocation ?? 0)
    currentWeatherManager.fetchCurrentWeather(lat: locationManager.lastLocation!.latitude, lon: locationManager.lastLocation!.longitude)
    forecastManager.fetchForecast(lat: locationManager.lastLocation!.latitude, lon: locationManager.lastLocation!.longitude)
  }
  
}
  
struct CenterWeatherView: View {
  @ObservedObject var locationManager: LocationManager
  @ObservedObject var weatherManager: CurrentWeatherManager
  
  var body: some View {
    VStack {
      Text(weatherManager.city)
        .kerning(1.0)
        .fontWeight(.bold)
        .foregroundColor(Color("TextColor"))
        .multilineTextAlignment(.center)
        .lineSpacing(4)
        .font(.title)
      Image(systemName: weatherManager.conditionString)
        .resizable()
        .foregroundColor(Color("TextColor"))
        .scaledToFill()
        .frame(width: 200, height: 200)
        .padding()
      Text("\(weatherManager.temp)°")
        .kerning(-1.0)
        .foregroundColor(Color("TextColor"))
        .fontWeight(.black)
        .font(.largeTitle)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var currentWeatherManager = CurrentWeatherManager()
  static var forecastManager = ForecastManager()
  static var locationManager = LocationManager()
  static var previews: some View {
    TodayView(currentWeatherManager: currentWeatherManager, locationManager: locationManager, forecastManager: forecastManager)
  }
}
