//
//  Vendor+CoreDataProperties.swift
//  MyExpense
//
//  Created by Christopher Koski on 7/16/22.
//
//

import Foundation
import CoreData


extension Vendor {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Vendor> {
    return NSFetchRequest<Vendor>(entityName: "Vendor")
  }
  
  @NSManaged public var name: String?
  @NSManaged public var expense: NSSet?
  @NSManaged public var id: String?
  
  var wrappedName: String {
    name ?? "Unknown"
  }
  
  var expenseArray: [Expense] {
    let set = expense as? Set<Expense> ?? []
    
    return set.sorted {
      $0.wrappedTitle < $1.wrappedTitle
    }
  }
}

// MARK: Generated accessors for expense
extension Vendor {
  
  @objc(addExpenseObject:)
  @NSManaged public func addToExpense(_ value: Expense)
  
  @objc(removeExpenseObject:)
  @NSManaged public func removeFromExpense(_ value: Expense)
  
  @objc(addExpense:)
  @NSManaged public func addToExpense(_ values: NSSet)
  
  @objc(removeExpense:)
  @NSManaged public func removeFromExpense(_ values: NSSet)
  
}

extension Vendor : Identifiable {
  
}
