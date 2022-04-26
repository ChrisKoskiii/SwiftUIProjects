//
//  ForecastCell.swift
//  Weatha
//
//  Created by Christopher Koski on 3/29/22.
//

import SwiftUI

struct ForecastCell: View {
  @ObservedObject var forecastManager: ForecastManager
  var minTemp: Int
  var maxTemp: Int
  var dayOfWeek: String
  var conditionString: String
  
  var body: some View {
    HStack {
      Text(dayOfWeek)
        .foregroundColor(Color("TextColor"))
        .frame(width: 90, alignment: .leading)
      Spacer()
      VStack(spacing: 5) {
        Text("Low: \(minTemp)")
          .foregroundColor(Color("TextColor"))
          .frame(width: 70, alignment: .leading)
        Text("High: \(maxTemp)")
          .foregroundColor(Color("TextColor"))
          .frame(width: 70, alignment: .leading)
      }
      Spacer()
      Image(systemName: conditionString)
        .foregroundColor(Color("TextColor"))
    }
    .padding(.leading)
    .padding(.trailing)
    .transition(.slide)
    Divider()
  }
}

struct ForecastCell_Previews: PreviewProvider {
  static var forecastManager = ForecastManager()
  static var previews: some View {
    ZStack {
      BackgroundGradient()
      ForecastCell(forecastManager: forecastManager, minTemp: 60, maxTemp: 80, dayOfWeek: "Monday", conditionString: "cloud")
    }
  }
}
