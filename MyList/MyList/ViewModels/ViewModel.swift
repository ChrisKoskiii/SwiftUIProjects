//
//  ViewModel.swift
//  MyList
//
//  Created by Christopher Koski on 5/5/22.
//

import Foundation

class ViewModel: ObservableObject {
  @Published var itemsArray: [Item] = [
    Item(name: "Take Vitamins", isDone: false),
    Item(name: "Walk the dog", isDone: false),
    Item(name: "Take out the trash", isDone: false),
    Item(name: "Study code", isDone: false),
    Item(name: "Read for 20 minutes", isDone: false),
    Item(name: "Take Vitamins", isDone: false),
    Item(name: "Brush teeth before bed", isDone: false)
  
  ]
  
  func updateItem(item: Item) {
    if let index = itemsArray.firstIndex(where: { $0.id == item.id }) {
      itemsArray[index] = item.updateCompletion()
    }
  }
  
}
