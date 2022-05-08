//
//  Item.swift
//  MyList
//
//  Created by Christopher Koski on 5/5/22.
//

import Foundation

struct Item: Hashable, Identifiable {
  let id: String = UUID().uuidString
  let name: String
  let isDone: Bool = false
}
