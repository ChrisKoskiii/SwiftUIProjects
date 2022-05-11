//
//  CalorieCounterApp.swift
//  CalorieCounter
//
//  Created by Christopher Koski on 5/11/22.
//

import SwiftUI

@main
struct CalorieCounterApp: App {
  @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
