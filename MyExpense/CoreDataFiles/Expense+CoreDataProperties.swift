//
//  Expense+CoreDataProperties.swift
//  MyExpense
//
//  Created by Christopher Koski on 7/16/22.
//
//

import Foundation
import CoreData


extension Expense {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
    return NSFetchRequest<Expense>(entityName: "Expense")
  }
  
  @NSManaged public var date: Date?
  @NSManaged public var price: Double
  @NSManaged public var title: String?
  @NSManaged public var category: Category
  @NSManaged public var vendor: Vendor
  @NSManaged public var receipt: Data?
  
  var wrappedTitle: String {
    title ?? "Unknown"
  }
  
  var formattedPrice: String {
    return "$" + String(format: "%.2f", price)
  }
  
  var formattedDate: String {
    guard let date = date else { return "Unknown" }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/YY"
    return dateFormatter.string(from: date)
  }
}

extension Expense : Identifiable {
  
}
