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
      Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
