//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/28/22.
//

import SwiftUI

struct ContentView: View {
  @AppStorage("selectedTab") var selectedTab: Tab = .home
  @ObservedObject var corevm: CoreDataViewModel
  var body: some View {
    TabView {
      HomeView(corevm: corevm)
        .tabItem {
          Label("Home", systemImage: "house")
        }
      ExpensesView(corevm: corevm)
        .tabItem {
          Label("Expenses", systemImage: "dollarsign.circle")
        }
      GenerateReportsView(corevm: corevm)
        .tabItem {
          Label("Reports", systemImage: "list.bullet.rectangle.portrait")
        }
      SettingsView(corevm: corevm)
        .tabItem {
          Label("Settings", systemImage: "gear")
        }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(corevm: CoreDataViewModel())
  }
}
