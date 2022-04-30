//
//  ForecastView.swift
//  itsWeather
//
//  Created by Christopher Koski on 4/28/22.
//

import SwiftUI

struct ForecastView: View {
  var body: some View {
    HStack(spacing: 13) {
      ForecastCellView()
      ForecastCellView()
      ForecastCellView()
      ForecastCellView()
      ForecastCellView()

    }
    .padding(.all, 20)
    .frame(maxWidth: .infinity)
    .background(.ultraThinMaterial, in:
                  RoundedRectangle(cornerRadius: 30, style: .continuous)
    )
    
    .strokeStyle()
    .shadow(color: Color("Shadow"), radius: 10, x: 0, y: 10)
    .padding(.leading)
    .padding(.trailing)
    
  }
}

struct ForecastView_Previews: PreviewProvider {
  static var previews: some View {
    ForecastView()
  }
}

struct ForecastCellView: View {
  var body: some View {
    VStack(spacing: 0) {
      Text("Monday")
        .font(.caption2.bold())
      Image(systemName: "cloud")
        .resizable()
        .scaledToFit()
        .frame(width: 40, height: 40)
      Text("H: 98")
        .font(.caption2.bold())
      Text("L: 78")
        .font(.caption2.bold())
    }
  }
}
