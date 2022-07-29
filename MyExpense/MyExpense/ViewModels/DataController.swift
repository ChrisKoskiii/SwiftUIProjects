//
//  DataManager.swift
//  MyExpense
//
//  Created by Christopher Koski on 7/14/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
  let persistentStoreContainer: NSPersistentContainer
  static let shared = DataController()
  
  @Published var savedExpenses: [Expense] = []
  @Published var savedCategories: [Category] = []
  @Published var savedVendors: [Vendor] = []
  
  private init() {
    persistentStoreContainer = NSPersistentContainer(name: "MyExpense")
    persistentStoreContainer.loadPersistentStores { description, error in
      if let error = error {
        fatalError("Unable to initialize Core Data \(error)")
      }
    }
  }
  
  func getExpenses() {
    let request = NSFetchRequest<Expense>(entityName: "Expense")
    
    do {
      try savedExpenses = persistentStoreContainer.viewContext.fetch(request)
    } catch {
      print("Error getting data. \(error.localizedDescription)")
    }
  }
  
  func getCategories() {
    let request = NSFetchRequest<Category>(entityName: "Category")
    
    do {
      try savedCategories = persistentStoreContainer.viewContext.fetch(request)
    } catch {
      print("Error getting data. \(error.localizedDescription)")
    }
  }
  
  func getVendors() {
    let request = NSFetchRequest<Vendor>(entityName: "Vendor")
    
    do {
      try savedVendors = persistentStoreContainer.viewContext.fetch(request)
    } catch {
      print("Error getting data. \(error.localizedDescription)")
    }
  }
  
  func addExpense(name: String, price: Double, date: Date, vendor: String, category: String, receipt: [Data]) {
    let newExpense = Expense(context: persistentStoreContainer.viewContext)
    newExpense.title = name
    newExpense.price = price
    newExpense.date = date
    newExpense.vendor = Vendor(context: persistentStoreContainer.viewContext)
    newExpense.vendor.name = vendor
    newExpense.vendor.id = UUID().uuidString
    newExpense.category = Category(context: persistentStoreContainer.viewContext)
    newExpense.category.name = category
    newExpense.category.id = UUID().uuidString
    newExpense.receipt = receipt
    
  }
  
  //  func addCategory(dataToSave: Category) {
  //      let newCategory = dataToSave
  //      saveData()
  //  }
  //
  //  func addVendor(dataToSave: Vendor) {
  //      let newVendor = dataToSave
  //      saveData()
  //  }
  
  func saveData() {
    do {
      try persistentStoreContainer.viewContext.save()
      getExpenses()
      getVendors()
      getCategories()
    } catch let error {
      print("Error: \(error)")
    }
  }
}
