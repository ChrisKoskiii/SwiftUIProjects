//
//  MonthlyTotalView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/30/22.
//

import SwiftUI

struct MonthlyTotalView: View {
  var body: some View {
    VStack {
      VStack(spacing: 0) {
        HStack {
          Spacer()
          Text("This month so far:")
            .font(.caption)
          Spacer()
        }
        HStack {
          Spacer()
          Text("$"+"1,223.50")
            .font(.largeTitle)
            .shadow(color: .secondary, radius: 3, x: 2, y: 4)
          Spacer()
        }
      }

      .padding(.horizontal)
      .padding(.top, 4)
    }
    .padding(.horizontal)
  }
}

struct MonthlyTotalView_Previews: PreviewProvider {
  static var previews: some View {
    MonthlyTotalView()
  }
}
