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
  
  private var currentMonthShown: Date = Date.now
  
  init() {
    getCurrentMonthString(from: Date.now)
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
  
}


