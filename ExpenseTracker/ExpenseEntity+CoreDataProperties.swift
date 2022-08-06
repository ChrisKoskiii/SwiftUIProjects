//
//  ExpenseEntity+CoreDataProperties.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/31/22.
//
//

import Foundation
import CoreData


extension ExpenseEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpenseEntity> {
        return NSFetchRequest<ExpenseEntity>(entityName: "ExpenseEntity")
    }

    @NSManaged public var category: String?
    @NSManaged public var cost: Double
    @NSManaged public var date: Date?
    @NSManaged public var title: String?
    @NSManaged public var vendor: String?
    @NSManaged public var receipt: Data?

  var wrappedCategory: String {
    category ?? "Unknown"
  }
  
  var wrappedDate: Date {
    date ?? Date.now
  }
  
  var wrappedTitle: String {
    title ?? "Unknown"
  }
  
  var wrappedVendor: String {
    vendor ?? "Unknown"
  }
}

extension ExpenseEntity : Identifiable {

}
