//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/28/22.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
  @StateObject var corevm = CoreDataViewModel()
  var body: some Scene {
        WindowGroup {
          ContentView(corevm: corevm)
        }
    }
}
