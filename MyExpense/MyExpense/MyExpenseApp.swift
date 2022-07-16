//
//  MyExpenseApp.swift
//  MyExpense
//
//  Created by Christopher Koski on 7/14/22.
//

import SwiftUI

@main
struct MyExpenseApp: App {
  @StateObject var dataController = DataController()
  
    var body: some Scene {
        WindowGroup {
            MainView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
