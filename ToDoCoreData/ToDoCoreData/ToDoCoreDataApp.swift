//
//  ToDoCoreDataApp.swift
//  ToDoCoreData
//
//  Created by Christopher Koski on 7/11/22.
//

import SwiftUI

@main
struct ToDoCoreDataApp: App {
  @StateObject var dataController = DataController()
  
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
