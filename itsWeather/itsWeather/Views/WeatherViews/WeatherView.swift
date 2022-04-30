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
        Text(weatherAPI.cityName ?? "- - -")
          .font(.title2.bold())
        Image(systemName: "cloud")
          .resizable()
          .scaledToFit()
          .foregroundStyle(
            .linearGradient(Gradient(colors: [.primary.opacity(0.5), .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
          )
          .frame(width: 200, height: 200)
        detailsStrip(weatherAPI: weatherAPI)
      }
      .padding(.all, 20)
      .frame(height: 350)
      .frame(maxWidth: .infinity)
      .background(.ultraThinMaterial, in:
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
      )
      .strokeStyle()
      .shadow(color: Color("Shadow") , radius: 10, x: 0, y: 10)
      .padding(.leading)
      .padding(.trailing)
    }
    
  }
  
  struct detailsStrip: View {
    @StateObject var weatherAPI: WeatherAPI
    
    var body: some View {
      HStack( spacing: 8) {
        Spacer()
        Text("\(String(weatherAPI.currentTemp ?? 0.0))° F")
          .font(.title2)
        Spacer()
        VStack(spacing: 6) {
          Image(systemName: "drop.fill")
            .foregroundStyle(.linearGradient(Gradient(colors: [.white, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .font(.body.bold())
          Text("45%")
            .font(.body)
            .fontWeight(.semibold)
        }
        Spacer()
        VStack {
          HStack(alignment: .center, spacing:4) {
            Text("H")
              .font(.title3.bold())
              .foregroundStyle(.linearGradient(Gradient(colors: [.red.opacity(0.1),.red]), startPoint: .topLeading, endPoint: .bottom))
            Text(":")
              .font(.body)
              .fontWeight(.semibold)
            Text("90°")
              .font(.body)
              .fontWeight(.semibold)
          }
          HStack(spacing: 4) {
            Text("L")
              .font(.title3.bold())
              .foregroundStyle(.linearGradient(Gradient(colors: [.blue.opacity(0.1),.blue]), startPoint: .topLeading, endPoint: .bottom))
            Text(":")
              .font(.body)
              .fontWeight(.semibold)
            Text("70°")
              .font(.body)
              .fontWeight(.semibold)
          }
        }
        Spacer()
      }
      .background(.ultraThinMaterial, in:
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
      )
    }
  }
}

struct WeatherView_Previews: PreviewProvider {
  static var weatherAPI = WeatherAPI()
  static var previews: some View {
    WeatherView(weatherAPI: weatherAPI)
  }
}
