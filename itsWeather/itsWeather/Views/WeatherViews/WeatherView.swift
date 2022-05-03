//
//  WeatherView.swift
//  itsWeather
//
//  Created by Christopher Koski on 4/28/22.
//

import SwiftUI

struct WeatherView: View {
  @Environment(\.colorScheme) var colorScheme
  
  @StateObject var weatherAPI: WeatherAPI
  
  var body: some View {
    ZStack {
      VStack {
        Text((weatherAPI.cityName?.uppercased())!)
          .font(.title3.bold())
          .kerning(5)
        Image(systemName: weatherAPI.condition)
          .resizable()
          .scaledToFit()
          .foregroundStyle(
            .linearGradient(Gradient(colors: [.primary.opacity(0.5), .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
          )
          .frame(width: 200, height: 150)
        Text((weatherAPI.description?.uppercased())!)
          .font(.footnote)
          .kerning(5)
          .multilineTextAlignment(.center)
        detailsStrip(weatherAPI: weatherAPI)
          .padding(.top, 10)
      }
      .padding(.all, 20)
      .frame(height: 350)
      .frame(maxWidth: .infinity)
      .thinMaterialBackground()
      .strokeStyle()
      .customShadow()
      .padding(.leading)
      .padding(.trailing)
    }
    
  }
  
  struct detailsStrip: View {
    @StateObject var weatherAPI: WeatherAPI
    
    var body: some View {
      HStack( spacing: 8) {
        Spacer()
        Text("\(String(weatherAPI.currentTemp ?? 0))°F")
          .font(.title2)
          .kerning(3)
        Spacer()
        VStack(spacing: 6) {
          Image(systemName: "drop.fill")
            .foregroundStyle(.linearGradient(Gradient(colors: [.white, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .font(.body.bold())
          Text("\(weatherAPI.humidity ?? 0)%")
            .font(.body)
            .kerning(3)
        }
        Spacer()
        VStack(spacing: 0) {
          HStack(spacing:4) {
            Text("H")
              .font(.title3)
              .foregroundStyle(.linearGradient(Gradient(colors: [.red.opacity(0.1),.red]), startPoint: .topLeading, endPoint: .bottom))
              .frame(width: 15)
            Text(":")
              .font(.body)
              .fontWeight(.semibold)
            Text("\(weatherAPI.maxTemp ?? 0)°")
              .font(.body)
              .kerning(3)
            
          }
          HStack(spacing: 4) {
            Text("L")
              .font(.title3.bold())
              .foregroundStyle(.linearGradient(Gradient(colors: [.blue.opacity(0.1),.blue]), startPoint: .topLeading, endPoint: .bottom))
              .frame(width: 15)
            Text(":")
              .font(.body)
              .fontWeight(.semibold)
            Text("\(weatherAPI.minTemp ?? 0)°")
              .font(.body)
              .kerning(3)
          }
        }
        Spacer()
      }
      .thinMaterialBackground()
    }
  }
}

struct WeatherView_Previews: PreviewProvider {
  static var weatherAPI = WeatherAPI()
  static var previews: some View {
    WeatherView(weatherAPI: weatherAPI)
  }
}
