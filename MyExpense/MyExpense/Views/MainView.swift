//
//  ContentView.swift
//  MyExpense
//
//  Created by Christopher Koski on 7/14/22.
//

import SwiftUI

struct MainView: View {
  let viewContext = DataController.shared.persistentStoreContainer.viewContext
  var body: some View {
    ZStack {
      TabView   {
        DashboardView(vm: DashboardViewModel(context: viewContext))
          .tabItem {
            Image(systemName: "filemenu.and.selection")
          }
        Text("Epense List")
//        ExpensesView()
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
