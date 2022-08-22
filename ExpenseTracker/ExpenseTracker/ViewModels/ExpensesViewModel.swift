//
//  ExpensesViewModel.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 8/11/22.
//

import Foundation

class ExpensesViewModel: ObservableObject {
  @Published var monthText: String = "January"
  @Published var monthStart: Date = Date.startOfMonth(Date.now)()
  @Published var monthEnd: Date = Date.endOfMonth(Date.now)()
  @Published var dateRangeExpenses: [ExpenseEntity] = []
  @Published var categories: [String] = []
  @Published var vendors: [String] = []
  @Published var selectedCategory: String?
  @Published var selectedVendor: String?
  
  private var currentMonthShown: Date = Date.now
  
  init() {
    getCurrentMonthString(from: Date.now)
    categories = categories.sorted { $0 < $1 }
    vendors = vendors.sorted { $0 < $1 }
  }
  
  func setCurrentMonth() {
    currentMonthShown = Date.now
    getCurrentMonthString(from: currentMonthShown)
  }
  
  func addMonth() {
    let newDate = Calendar.current.date(byAdding: .month, value: 1, to: currentMonthShown)!
    currentMonthShown = newDate
    getCurrentMonthString(from: newDate)
    monthStart = Date.startOfMonth(newDate)()
    monthEnd = Date.endOfMonth(newDate)()
  }
  
  func subtractMonth() {
    let newDate = Calendar.current.date(byAdding: .month, value: -1, to: currentMonthShown)!
    currentMonthShown = newDate
    getCurrentMonthString(from: newDate)
    monthStart = Date.startOfMonth(newDate)()
    monthEnd = Date.endOfMonth(newDate)()
  }
  
  func getCurrentMonthString(from date: Date) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "LLLL"
    monthText = dateFormatter.string(from: date)
  }
  
  
  func fetchData(from coreData: CoreDataViewModel) {
    fetchCategories(from: coreData)
    fetchVendors(from: coreData)
  }
  
  func fetchCategories(from coreData: CoreDataViewModel) {
    for expense in coreData.savedExpenses {
      if !categories.contains(expense.wrappedCategory) {
        categories.append(expense.wrappedCategory)
      }
    }
  }
  
  func fetchVendors(from coreData: CoreDataViewModel) {
    for expense in coreData.savedExpenses {
      if !vendors.contains(expense.wrappedVendor) {
        vendors.append(expense.wrappedVendor)
      }
    }
  }
}


