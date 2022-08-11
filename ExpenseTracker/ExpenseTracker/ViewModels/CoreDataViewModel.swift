//
//  CoreDataViewModel.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/28/22.
//

import CoreData
import UIKit
import CloudKit

class CoreDataViewModel: ObservableObject {
  
  let container: NSPersistentContainer
  
  @Published var savedExpenses: [ExpenseEntity] = []
  @Published var recentExpenses: [ExpenseEntity] = []
  @Published var monthlyTotal: Double = 0.00
  @Published var dateRangeExpenses: [ExpenseEntity] = []
  @Published var dateRangeTotal: Double = 0.0
  @Published var categoriesDict: [String: Double] = [:]
  
  init() {
    container = NSPersistentCloudKitContainer(name: "ExpenseContainer")
    container.viewContext.automaticallyMergesChangesFromParent = true
    container.loadPersistentStores { description, error in
      if let error = error {
        print("Error loading Core Data, \(error)")
      }
    }
    fetchExpenses()
    getRecent(expenses: savedExpenses)
    if let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) {
      getDateRangeExpenses(startDate: startDate, endDate: Date.now)
    }
  }
  
  func fetchExpenses() {
    let request = NSFetchRequest<ExpenseEntity>(entityName: "ExpenseEntity")
    let sort = NSSortDescriptor(key: #keyPath(ExpenseEntity.date), ascending: false)
    request.sortDescriptors = [sort]
    
    do {
      savedExpenses = try container.viewContext.fetch(request)
      getRecent(expenses: savedExpenses)
      monthlyTotal = getTotal(from: savedExpenses)
      updateCategories()
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
      updateCategories()
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
  
  func updateCategories() {
    getAllCategories()
  }
  
  func categoryTotal() {
    for expense in dateRangeExpenses {
      for (key, value) in categoriesDict {
        if expense.wrappedCategory == key {
          var newValue = value
          newValue += expense.cost
          categoriesDict.updateValue(newValue, forKey: key)
        }
      }
    }
    print(categoriesDict)
  }
  
  func getAllCategories() {
    for expense in savedExpenses {
      categoriesDict[expense.wrappedCategory] = 0
    }
    print(categoriesDict)
  }
  
}
