//
//  ItemFolder+CoreDataProperties.swift
//  ToDoCoreData
//
//  Created by Christopher Koski on 7/12/22.
//
//

import Foundation
import CoreData


extension ItemList {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemList> {
    return NSFetchRequest<ItemList>(entityName: "ItemList")
  }
  
  @NSManaged public var title: String?
  @NSManaged public var item: Item?
  @NSManaged public var items: NSSet?
  
  var wrappedTitle: String {
    title ?? "Unknown"
  }
  var itemsArray: [Item] {
    let set = items as? Set<Item> ?? []
    
    return set.sorted {
      $0.wrappedTitle < $1.wrappedTitle
    }
  }
}

extension ItemList : Identifiable {
  
}
