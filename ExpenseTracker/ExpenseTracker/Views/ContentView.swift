//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/28/22.
//

import SwiftUI

struct ContentView: View {
  @AppStorage("selectedTab") var selectedTab: Tab = .home
  var body: some View {
    ZStack(alignment: .bottom) {
        switch selectedTab {
        case .home:
          HomeView()
        case .explore:
          Text("Hello World")
        case .notification:
          Text("Hello World")
        case .library:
          Text("Hello World")
        }
      
      TabBar()
    }
    .safeAreaInset(edge: .bottom) {
      Color.clear.frame(height: 44)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
