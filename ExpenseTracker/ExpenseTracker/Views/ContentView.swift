//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/28/22.
//

import SwiftUI

struct ContentView: View {
  @AppStorage("selectedTab") var selectedTab: Tab = .home
  @StateObject var vm = CoreDataViewModel()
  
  var body: some View {
    ZStack(alignment: .bottom) {
      switch selectedTab {
      case .home:
        HomeView(vm : vm)
      case .expenses:
        ExpensesView(vm: vm)
      case .reports:
        ReportsView()
      case .settings:
        SettingsView()
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
