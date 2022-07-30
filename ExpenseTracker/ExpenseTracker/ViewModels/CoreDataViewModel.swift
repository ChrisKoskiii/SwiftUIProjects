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
    let sort = NSSortDescriptor(key: #keyPath(ExpenseEntity.date), ascending: true)
    request.sortDescriptors = [sort]
    do {
      savedExpenses = try container.viewContext.fetch(request)
    } catch let error {
      print("Error fetching, \(error)")
    }
  }
  
  func addExpense(title: String, cost: Double, vendor: String, category: String, date: String) {
    let newExpense = ExpenseEntity(context: container.viewContext)
    newExpense.title = title
    newExpense.cost = cost
    newExpense.vendor = vendor
    newExpense.category = category
    newExpense.date = date
    saveData()
  }
  
  func deleteExpense(indexSet: IndexSet) {
    guard let index = indexSet.first else { return }
    let entity = savedExpenses[index]
    container.viewContext.delete(entity)
    saveData()
  }
  
  func updateExpense(entity: ExpenseEntity, title: String, cost: Double, vendor: String, category: String, date: String) {
    entity.title = title
    entity.cost = cost
    entity.vendor = vendor
    entity.category = category
    entity.date = date
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
