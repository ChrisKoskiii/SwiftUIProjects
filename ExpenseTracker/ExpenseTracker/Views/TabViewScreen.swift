//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/28/22.
//

import SwiftUI

struct TabViewScreen: View {
  @AppStorage("selectedTab") var selectedTab: Tab = .home
  @ObservedObject var corevm: CoreDataViewModel
  
  var body: some View {
    TabView {
      HomeView(coreVM: corevm)
        .tabItem {
          Label("Home", systemImage: "house")
        }
      ExpensesView(coreVM: corevm)
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
    .accentColor(Color.brandPrimary)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    TabViewScreen(corevm: CoreDataViewModel())
  }
}
