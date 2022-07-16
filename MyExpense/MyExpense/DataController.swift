//
//  DataManager.swift
//  MyExpense
//
//  Created by Christopher Koski on 7/14/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
  let container = NSPersistentContainer(name: "MyExpense")
  
  init() {
    container.loadPersistentStores { description, error in
      if let error = error {
        print("Core data failed to load: \(error.localizedDescription)")
      }
    }
  }
}
