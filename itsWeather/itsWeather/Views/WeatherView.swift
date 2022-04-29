//
//  WeatherView.swift
//  itsWeather
//
//  Created by Christopher Koski on 4/28/22.
//

import SwiftUI

struct WeatherView: View {
  var body: some View {
    VStack {
      Text("Wellington, FL")
        .font(.title2.bold())
      Image(systemName: "cloud")
        .resizable()
        .scaledToFit()
        .foregroundColor(.blue)
        .frame(width: 200, height: 200)
      HStack(spacing: 8) {
        Text("98 F")
        Text("45% Rain")
        Text("Hi: 90, Low: 80")
      }
    }
    .padding(.all, 20)
    .frame(width: 350)
    .background(.ultraThinMaterial, in:
      RoundedRectangle(cornerRadius: 30, style: .continuous)
    )
    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
    
  }
}

struct WeatherView_Previews: PreviewProvider {
  static var previews: some View {
    WeatherView()
  }
}
