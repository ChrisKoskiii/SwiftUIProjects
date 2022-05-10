//
//  Item.swift
//  MyList
//
//  Created by Christopher Koski on 5/5/22.
//

import Foundation

struct Item: Hashable, Identifiable, Codable {
  let id: String
  let name: String
  let isDone: Bool
  
  init(id: String = UUID().uuidString, name: String, isDone: Bool) {
    self.id = id
    self.name = name
    self.isDone = isDone
  }
  
  func updateCompletion() -> Item {
    return Item(id: id, name: name, isDone: !isDone)
  }
}
