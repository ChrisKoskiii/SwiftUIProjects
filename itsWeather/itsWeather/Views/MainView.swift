//
//  MainView.swift
//  itsWeather
//
//  Created by Christopher Koski on 4/28/22.
//

import SwiftUI
import CoreLocation
import CoreLocationUI

struct MainView: View {
  @StateObject var locationManager = LocationManager()
  @StateObject var weatherAPI = WeatherAPI()
  
  var body: some View {
    ZStack {
      BackgroundView()
      VStack(spacing: 30) {
        HStack {
          LocationButton(locationManager: locationManager, weatherAPI: weatherAPI)
          SearchBar()
          SearchButton()
        }
        .frame(maxWidth: .infinity)
        .shadow(color: Color("Shadow"), radius: 10, x: 0, y: 10)
        .padding(.leading)
        .padding(.trailing)
        Spacer()
        WeatherView(weatherAPI: weatherAPI)
        ForecastView()
        Spacer()
        Spacer()
      }
    }
    .onAppear {
      
    }
  }
}

//MARK: Utilities
struct LocationButton: View {
  @StateObject var locationManager: LocationManager
  @StateObject var weatherAPI: WeatherAPI
  
  @State var tapLocation = false
  var body: some View {
    Button {
      withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
        tapLocation = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
          withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
            tapLocation = false
          }
        }
      }
      locationManager.requestLocation()
      weatherAPI.fetchCurrentWeather(lat: locationManager.location?.latitude ?? 0.0, lon: locationManager.location?.longitude ?? 0.0)
      weatherAPI.fetchForecast(lat: locationManager.location?.latitude ?? 0.0, lon: locationManager.location?.longitude ?? 0.0)
    } label: {
      Image(systemName: "location.circle")
        .resizable()
        .scaledToFit()
        .symbolRenderingMode(.palette)
        .foregroundStyle(Color("Text"), Color("Shadow"))
        .frame(width: 40, height: 40)
        .padding(.all, 8)
        .background(.ultraThinMaterial, in:
                      RoundedRectangle(cornerRadius: 30, style: .continuous)
        )
        .scaleEffect(tapLocation ? 1.2 : 1)
      //        .animation(.spring(response: 0.4, dampingFraction: 0.6))
    }
  }
}

struct SearchBar: View {
  @State var textfieldText: String = ""
  
  var body: some View {
    TextField("Location", text: $textfieldText)
      .multilineTextAlignment(.center)
      .padding(.trailing)
      .frame(height: 55)
      .background(.ultraThinMaterial, in:
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
      )
  }
}

struct SearchButton: View {
  var body: some View {
    Image(systemName: "magnifyingglass.circle")
      .resizable()
      .scaledToFit()
      .symbolRenderingMode(.palette)
      .foregroundStyle(.primary, .secondary)
      .frame(width: 40, height: 40)
      .padding(.all, 8)
      .background(.ultraThinMaterial, in:
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
      )
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
    MainView()
      .preferredColorScheme(.dark)
  }
}