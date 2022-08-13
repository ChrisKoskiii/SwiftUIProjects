//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/28/22.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
  @StateObject var coreVM = CoreDataViewModel()
  var body: some Scene {
        WindowGroup {
          TabViewScreen(corevm: coreVM)
        }
    }
}
