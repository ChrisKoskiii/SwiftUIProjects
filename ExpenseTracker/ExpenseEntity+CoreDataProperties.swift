//
//  ExpenseEntity+CoreDataProperties.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/30/22.
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
    @NSManaged public var date: String?
    @NSManaged public var title: String?
    @NSManaged public var vendor: String?
  
  var wrappedCategory: String {
    category ?? "Unknown"
  }
  
  var wrappedDate: String {
    date ?? "Unkown"
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
