//
//  ContentView.swift
//  MyExpense
//
//  Created by Christopher Koski on 7/14/22.
//

import SwiftUI

struct MainView: View {
  
  var body: some View {
    ZStack {
      TabView {
        DashboardView()
          .tabItem {
            Image(systemName: "filemenu.and.selection")
          }
        ExpensesView()
          .tabItem {
            Image(systemName: "dollarsign.circle")
          }
        Text("Hello world")
          .tabItem {
            Image(systemName: "calendar")
          }
        SettingsView()
          .tabItem {
            Image(systemName: "gear")
          }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
