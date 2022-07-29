//
//  MyExpenseApp.swift
//  MyExpense
//
//  Created by Christopher Koski on 7/14/22.
//

import SwiftUI

@main
struct MyExpenseApp: App {
  
    var body: some Scene {
        WindowGroup {
          
          let viewContext = DataController.shared.persistentStoreContainer.viewContext
          MainView()
            .environment(\.managedObjectContext, viewContext)
        }
    }
}
