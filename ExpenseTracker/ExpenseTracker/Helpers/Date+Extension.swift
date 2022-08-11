//
//  Date+Extension.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/29/22.
//

import Foundation

extension Date {
  func formatDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.setLocalizedDateFormatFromTemplate("MM/dd")
    return dateFormatter.string(from: self)
  }
  
  func addOrSubtractMonth(month: Int) -> Date {
    Calendar.current.date(byAdding: .month, value: month, to: Date())!
  }
  
  func addOrSubtractYear(year: Int) -> Date {
    Calendar.current.date(byAdding: .year, value: year, to: Date())!
  }
}
