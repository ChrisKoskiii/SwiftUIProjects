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
  @Published var dateRangeExpenses: [ExpenseEntity] = []
  @Published var dateRangeTotal: Double = 0.0
  
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
      monthlyTotal = getTotal(from: savedExpenses)
    } catch let error {
      print("Error fetching, \(error)")
    }
  }
  
  func getRecent(expenses: [ExpenseEntity]) {
    recentExpenses = Array(savedExpenses.prefix(5))
  }
  
  func getDateRangeExpenses(startDate: Date, endDate: Date) {
    let request = NSFetchRequest<ExpenseEntity>(entityName: "ExpenseEntity")
    let sort = NSSortDescriptor(key: #keyPath(ExpenseEntity.date), ascending: false)
    
    let predicate = NSPredicate(format: "%@ >= date AND %@ <= date", argumentArray: [endDate, startDate])
    request.predicate = predicate
    request.sortDescriptors = [sort]
    
    do {
      dateRangeExpenses = try container.viewContext.fetch(request)
      dateRangeTotal = getTotal(from: dateRangeExpenses)
      print("Success")
      print(dateRangeExpenses)
    } catch let error {
      print("Error fetching expenses for date range, \(error)")
    }
  }
  
  func addExpense(title: String, cost: Double, vendor: String, category: String, date: Date, receipt: Data) {
    let newExpense = ExpenseEntity(context: container.viewContext)
    newExpense.title = title
    newExpense.cost = cost
    newExpense.vendor = vendor
    newExpense.category = category
    newExpense.date = date
    newExpense.receipt = receipt
    saveData()
  }
  
  func addExpenseWithoutImage(title: String, cost: Double, vendor: String, category: String, date: Date) {
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
  
  func updateExpense(entity: ExpenseEntity, title: String, cost: Double, vendor: String, category: String, date: Date, receipt: Data?) {
    entity.title = title
    entity.cost = cost
    entity.vendor = vendor
    entity.category = category
    entity.date = date
    entity.receipt = receipt
    saveData()
  }
  
  func updateExpenseWithoutImage(entity: ExpenseEntity, title: String, cost: Double, vendor: String, category: String, date: Date) {
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
      monthlyTotal = getTotal(from: savedExpenses)
    } catch let error {
      print("Error saving , \(error)")
    }
  }
  
  func getImageData(_ image: UIImage) -> Data {
    return image.jpegData(compressionQuality: 1.0)!
  }
  
  func getTotal(from expenses: [ExpenseEntity]) -> Double {
    return expenses.lazy.compactMap { $0.cost }
      .reduce(0, +)
  }
  
  
  
}
