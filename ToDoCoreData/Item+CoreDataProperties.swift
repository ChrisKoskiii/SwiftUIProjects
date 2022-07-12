//
//  Item+CoreDataProperties.swift
//  ToDoCoreData
//
//  Created by Christopher Koski on 7/11/22.
//
//

import Foundation
import CoreData


extension Item {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
    return NSFetchRequest<Item>(entityName: "Item")
  }
  
  @NSManaged public var title: String?
  @NSManaged public var isDone: Bool
  @NSManaged public var id: UUID?
  
  var wrappedTitle: String {
    title ?? "Unknown"
  }
  
}

extension Item : Identifiable {
  
}
