//
//  Expense+CoreDataProperties.swift
//  MyExpense
//
//  Created by Christopher Koski on 7/14/22.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var price: Int16
    @NSManaged public var title: String?
    @NSManaged public var date: Date?
    @NSManaged public var category: String?
  
  var wrappedTitle: String {
    title ?? "Unknown"
  }
  
  var wrappedCategory: String {
    category ?? "Unknown"
  }
}

extension Expense : Identifiable {

}
