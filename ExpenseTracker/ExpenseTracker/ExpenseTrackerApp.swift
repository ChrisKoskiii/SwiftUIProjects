//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 4/24/22.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
  @StateObject var transactionListVM = TransactionListViewModel()
  
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(transactionListVM)
        }
    }
}
