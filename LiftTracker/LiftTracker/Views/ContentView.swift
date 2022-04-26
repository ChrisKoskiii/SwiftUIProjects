//
//  ContentView.swift
//  LiftTracker
//
//  Created by Christopher Koski on 2/3/22.
//

import SwiftUI

struct ContentView: View {
  
  var body: some View {
    TabView {
      WorkoutListView()
        .tabItem {
          Image(systemName: "flame")
          Text("Workout")
        }
      HistoryView()
        .tabItem {
          Image(systemName: "clock")
          Text("History")
        }
      SettingsView()
        .tabItem {
          Image(systemName: "gear")
          Text("Settings")
        }
    }
    .accentColor(.green)
  }
}

//struct ContentView_Previews: PreviewProvider {
//  static var previews: some View {
//    ContentView()
//  }
//}
