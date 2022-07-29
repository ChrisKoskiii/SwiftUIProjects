//
//  CoreDataViewModel.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/28/22.
//

import Foundation
import CoreData

class CoreDataViewModel: ObservableObject {
  
  let container: NSPersistentContainer
  @Published var savedExpenses: [ExpenseEntity] = []
  
  init() {
    container = NSPersistentContainer(name: "ExpenseContainer")
    container.loadPersistentStores { description, error in
      if let error = error {
        print("Error loading Core Data, \(error)")
      }
    }
    fetchExpenses()
  }
  
  func fetchExpenses() {
    let request = NSFetchRequest<ExpenseEntity>(entityName: "ExpenseEntity")
    
    do {
      savedExpenses = try container.viewContext.fetch(request)
    } catch let error {
      print("Error fetching, \(error)")
    }
  }
  
  func addExpense(title: String, cost: Double, vendor: String, category: String) {
    let newExpense = ExpenseEntity(context: container.viewContext)
    newExpense.title = title
    newExpense.cost = cost
    newExpense.vendor = vendor
    newExpense.category = category
    saveData()
  }
  
  func deleteExpense(indexSet: IndexSet) {
    guard let index = indexSet.first else { return }
    let entity = savedExpenses[index]
    container.viewContext.delete(entity)
    saveData()
  }
  
  func updateExpense(entity: ExpenseEntity) {
    let currentTitle = entity.title ?? ""
    let newTitle = currentTitle + "!"
    entity.title = newTitle
    saveData()
  }
  
  func saveData() {
    do {
      try container.viewContext.save()
      fetchExpenses()
    } catch let error {
      print("Error saving , \(error)")
    }
    
  }
  
}
