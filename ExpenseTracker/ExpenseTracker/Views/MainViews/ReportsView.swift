//
//  ReportsView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/29/22.
//

import SwiftUI

struct ReportsView: View {
  @State private var opacity = 0.0
  var body: some View {
    ZStack {
      BackgroundView()
      Text("Coming soon")
    }
    .onAppear {
      DispatchQueue.main.async {
        withAnimation {
          opacity = 1.0
        }
      }
    }
  }
}

struct ReportsView_Previews: PreviewProvider {
  static var previews: some View {
    ReportsView()
  }
}
