//
//  CoreDataViewModel.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/28/22.
//

import Foundation
import CoreData
import UIKit

class CoreDataViewModel: ObservableObject {
  
  let container: NSPersistentContainer
  
  @Published var savedExpenses: [ExpenseEntity] = []
  @Published var recentExpenses: [ExpenseEntity] = []
  @Published var monthlyTotal: Double = 0.00
  
  init() {
    container = NSPersistentContainer(name: "ExpenseContainer")
    container.loadPersistentStores { description, error in
      if let error = error {
        print("Error loading Core Data, \(error)")
      }
    }
    fetchExpenses()
    getRecent(expenses: savedExpenses)
  }
  
  func fetchExpenses() {
    let request = NSFetchRequest<ExpenseEntity>(entityName: "ExpenseEntity")
    let sort = NSSortDescriptor(key: #keyPath(ExpenseEntity.date), ascending: false)
    request.sortDescriptors = [sort]
    
    do {
      savedExpenses = try container.viewContext.fetch(request)
      getRecent(expenses: savedExpenses)
      getMonthlyTotal()
    } catch let error {
      print("Error fetching, \(error)")
    }
  }
  
  func getRecent(expenses: [ExpenseEntity]) {
    recentExpenses = Array(savedExpenses.prefix(5))
  }
  
  func addExpense(title: String, cost: Double, vendor: String, category: String, date: String, receipt: Data) {
    let newExpense = ExpenseEntity(context: container.viewContext)
    newExpense.title = title
    newExpense.cost = cost
    newExpense.vendor = vendor
    newExpense.category = category
    newExpense.date = date
    newExpense.receipt = receipt
    saveData()
  }
  
  func addExpenseWithoutImage(title: String, cost: Double, vendor: String, category: String, date: String) {
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
  
  func updateExpense(entity: ExpenseEntity, title: String, cost: Double, vendor: String, category: String, date: String, receipt: Data?) {
    entity.title = title
    entity.cost = cost
    entity.vendor = vendor
    entity.category = category
    entity.date = date
    entity.receipt = receipt
    saveData()
  }
  
  func updateExpenseWithoutImage(entity: ExpenseEntity, title: String, cost: Double, vendor: String, category: String, date: String) {
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
      getMonthlyTotal()
    } catch let error {
      print("Error saving , \(error)")
    }
  }
  
  func getImageData(_ image: UIImage) -> Data {
    return image.jpegData(compressionQuality: 1.0)!
  }
  
  func getMonthlyTotal() {
    monthlyTotal = savedExpenses.lazy.compactMap { $0.cost }
      .reduce(0, +)
  }
  
}
