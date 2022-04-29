//
//  MainView.swift
//  itsWeather
//
//  Created by Christopher Koski on 4/28/22.
//

import SwiftUI

struct MainView: View {
  var body: some View {
    ZStack {
      BackgroundView()
      VStack(spacing: 30) {
      WeatherView()
      ForecastView()
      }
    }
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
    MainView()
      .preferredColorScheme(.dark)
  }
}
