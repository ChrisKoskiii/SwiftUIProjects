//
//  DataController.swift
//  CalorieCounter
//
//  Created by Christopher Koski on 5/11/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
  let container = NSPersistentContainer(name: "FoodModel")
  
  init() {
    container.loadPersistentStores { description, error in
      if let error = error {
        print("Failed to load the data \(error.localizedDescription)")
      }
    }
  }
  
  func save(context: NSManagedObjectContext) {
    do {
      try context.save()
      print("Data saved")
    } catch {
      print("We could not save the data.")
    }
  }
  
  func addFood(title: String, calories: Double, context: NSManagedObjectContext) {
    let food = Food(context: context)
    food.id = UUID()
    food.date = Date()
    food.title = title
    food.calories = calories
    
    save(context: context)
  }
  
  func editFood(food: Food, title: String, calories: Double, context: NSManagedObjectContext) {
    food.date = Date()
    food.title = title
    food.calories = calories
    
    save(context: context)
  }
}
