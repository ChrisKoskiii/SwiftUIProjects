//
//  Category+CoreDataProperties.swift
//  MyExpense
//
//  Created by Christopher Koski on 7/18/22.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var expense: NSSet?

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
extension Category {

    @objc(addExpenseObject:)
    @NSManaged public func addToExpense(_ value: Expense)

    @objc(removeExpenseObject:)
    @NSManaged public func removeFromExpense(_ value: Expense)

    @objc(addExpense:)
    @NSManaged public func addToExpense(_ values: NSSet)

    @objc(removeExpense:)
    @NSManaged public func removeFromExpense(_ values: NSSet)

}

extension Category : Identifiable {

}
