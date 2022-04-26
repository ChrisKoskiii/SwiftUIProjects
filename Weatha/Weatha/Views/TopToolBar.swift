//
//  Toolbar.swift
//  Weatha
//
//  Created by Christopher Koski on 4/4/22.
//

import SwiftUI

struct TopToolBar: View {
  @ObservedObject var locationManager: LocationManager
  @ObservedObject var currentWeatherManager: CurrentWeatherManager
  @ObservedObject var forecastManager: ForecastManager
  @State var searchText = ""
  var body: some View {
    VStack {
      HStack {
        LocationButton(locationManager: locationManager, currentWeatherManager: currentWeatherManager, forecastManager: forecastManager)
        SearchBar(searchText: $searchText)
        SearchButton()
      }
      Spacer()
    }
  }
}

struct LocationButton: View {
  
  @ObservedObject var locationManager: LocationManager
  @ObservedObject var currentWeatherManager: CurrentWeatherManager
  @ObservedObject var forecastManager: ForecastManager
  @State var tapLocation = false
  @State var searchText = ""
  var body: some View {
    Button {
      print("Pressed")
      getUserLocation()
      
    } label : {
      Image(systemName: "location.circle")
        .resizable()
        .frame(width: 30, height: 30)
        .foregroundColor(Color("TextColor"))
        .padding()
        .scaleEffect(tapLocation ? 1.2 : 1)
        .animation(.spring(response: 0.4, dampingFraction: 0.6))
        .onTapGesture {
          tapLocation = true
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            tapLocation = false
          }
        }
    }
  }
  
  func getUserLocation() {
    locationManager.manager.requestWhenInUseAuthorization()
    print(locationManager.lastLocation ?? 0)
    currentWeatherManager.fetchCurrentWeather(lat: locationManager.lastLocation!.latitude, lon: locationManager.lastLocation!.longitude)
    forecastManager.fetchForecast(lat: locationManager.lastLocation!.latitude, lon: locationManager.lastLocation!.longitude)
  }
}

struct SearchBar: View {
  @Binding var searchText: String
  var currentWeatherManager = CityCurrentWeather()
  var body: some View {
    ZStack {
      Rectangle()
        .foregroundColor(Color("TextColor"))
        .frame(height: 40)
        .cornerRadius(13)
      HStack {
        Button {
          currentWeatherManager.fetchCurrentWeather(cityName: searchText)
        } label: {
          Image(systemName: "magnifyingglass")
        }
        TextField("Search", text: $searchText)
          .modifier(TextFieldClearButton(text: $searchText))
          .multilineTextAlignment(.leading)
          .padding(.trailing)
        
      }
      .foregroundColor(Color("Color3"))
      .padding(.leading, 13)
      
    }
  }
}

struct TextFieldClearButton: ViewModifier {
  @Binding var text: String
  
  func body(content: Content) -> some View {
    HStack {
      content
      
      if !text.isEmpty {
        Button(
          action: { self.text = "" },
          label: {
            Image(systemName: "x.circle.fill")
              .foregroundColor(Color("Color3"))
          }
        )
      }
    }
  }
}

struct SearchButton: View {
  @State var tapSearch = false
  var body: some View {
    Image(systemName: "magnifyingglass")
      .resizable()
      .frame(width: 28, height: 28)
      .foregroundColor(Color("TextColor"))
      .scaleEffect(tapSearch ? 1.2 : 1)
      .animation(.spring(response: 0.4, dampingFraction: 0.6))
      .onTapGesture {
        tapSearch = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
          tapSearch = false
        }
      }
      .padding()
  }
}

struct Toolbar_Previews: PreviewProvider {
  static var forecastManager = ForecastManager()
  static var currentWeatherManager = CurrentWeatherManager()
  static var locationManager = LocationManager()
  
  static var previews: some View {
    ZStack {
      BackgroundGradient()
      TopToolBar(locationManager: locationManager, currentWeatherManager: currentWeatherManager, forecastManager: forecastManager)
    }
  }
}
