//
//  ContentView.swift
//  GreySkullLP
//
//  Created by Christopher Koski on 7/1/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
      TabView {
        HomeView()
          .tabItem {
            Image(systemName: "house")
          }
        HistoryView()
          .tabItem {
            Image(systemName: "clock")
          }
        GraphView()
          .tabItem {
            Image(systemName: "chart.xyaxis.line")
          }
        SettingsView()
          .tabItem {
            Image(systemName: "gear")
          }
      }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
