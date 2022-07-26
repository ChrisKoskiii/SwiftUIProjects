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
  
  @Published var savedExpenses: [Expense] = []
  @Published var savedCategories: [Category] = []
  @Published var savedVendors: [Vendor] = []
  
  init() {
    container.loadPersistentStores { description, error in
      if let error = error {
        print("Core data failed to load: \(error.localizedDescription)")
      }
    }
  }
  
  func getExpenses() {
    let request = NSFetchRequest<Expense>(entityName: "Expense")
    
    do {
      try savedExpenses = container.viewContext.fetch(request)
    } catch {
      print("Error getting data. \(error.localizedDescription)")
    }
  }
  
  func getCategories() {
    let request = NSFetchRequest<Category>(entityName: "Category")
    
    do {
      try savedCategories = container.viewContext.fetch(request)
    } catch {
      print("Error getting data. \(error.localizedDescription)")
    }
  }
  
  func getVendors() {
    let request = NSFetchRequest<Vendor>(entityName: "Vendor")
    
    do {
      try savedVendors = container.viewContext.fetch(request)
    } catch {
      print("Error getting data. \(error.localizedDescription)")
    }
  }
  
  func addExpense(name: String, price: Double, date: Date, vendor: String, category: String) {
    let newExpense = Expense(context: container.viewContext)
    newExpense.title = name
    newExpense.price = price
    newExpense.date = date
    newExpense.vendor = Vendor(context: container.viewContext)
    newExpense.vendor.name = vendor
    newExpense.category = Category(context: container.viewContext)
    newExpense.category.name = category
    
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
      try container.viewContext.save()
      getExpenses()
      getVendors()
      getCategories()
    } catch let error {
      print("Error: \(error)")
    }
  }
}
