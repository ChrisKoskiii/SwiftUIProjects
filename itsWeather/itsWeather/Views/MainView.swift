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
  @State var isShown = false
  @State var opacity = 0.0
  @State var scale = 0.0
  var body: some View {
    ZStack {
      BackgroundView()
      VStack(spacing: 30) {
        getLocationButton
        Spacer()
        WeatherView(weatherAPI: weatherAPI)
        ForecastView(weatherAPI: weatherAPI)
        Spacer()
        Spacer()
      }
      .opacity(opacity)
      .scaleEffect(scale)
      .animate {
        opacity = 1
        scale = 1
      }
    }
  }
  
  var getLocationButton: some View {
    HStack {
      LocationButton(locationManager: locationManager, weatherAPI: weatherAPI)
        .frame(maxWidth: .infinity)
        .customShadow()
        .padding(.leading)
        .padding(.trailing)
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
      HStack(spacing: 0) {
        Image(systemName: "location.circle")
          .resizable()
          .scaledToFit()
          .symbolRenderingMode(.palette)
          .foregroundStyle(Color("Text"), Color("Shadow"))
          .frame(width: 40, height: 40)
          .padding(.all, 8)
        Text("Get Location".uppercased())
          .font(.footnote)
          .kerning(3)
          .padding(.trailing, 8)
          .foregroundStyle(.linearGradient(Gradient(colors: [.primary.opacity(0.8),.primary]), startPoint: .topLeading, endPoint: .bottom))
      }
      .thinMaterialBackground()
      .scaleEffect(tapLocation ? 1.2 : 1)
      .padding(.top, 8)
    }
  }
}

//struct SearchBar: View {
//  @State var textfieldText: String = ""
//  var body: some View {
//    TextField("Location", text: $textfieldText)
//      .multilineTextAlignment(.center)
//      .padding(.trailing)
//      .frame(height: 55)
//      .thinMaterialBackground()
//  }
//}

//struct SearchButton: View {
//  @State var tapLocation = false
//  var body: some View {
//    Button {
//      withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
//        tapLocation = true
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//          withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
//            tapLocation = false
//          }
//        }
//      }
//    } label : {
//    Image(systemName: "magnifyingglass.circle")
//      .resizable()
//      .scaledToFit()
//      .symbolRenderingMode(.palette)
//      .foregroundStyle(Color("Text"), Color("Shadow"))
//      .frame(width: 40, height: 40)
//      .padding(.all, 8)
//      .thinMaterialBackground()
//      .scaleEffect(tapLocation ? 1.2 : 1)
//    }
//  }
//}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
    MainView()
      .preferredColorScheme(.dark)
  }
}
