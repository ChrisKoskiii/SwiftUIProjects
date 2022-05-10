//
//  ViewModel.swift
//  MyList
//
//  Created by Christopher Koski on 5/5/22.
//

import Foundation

class ViewModel: ObservableObject {
  @Published var itemsArray: [Item] = [] {
    didSet {
      saveItems()
    }
  }
  
  let itemsKey: String = "items_list"
  
  init() {
    getItems()
  }
  
  func getItems() {
    guard
      let data = UserDefaults.standard.data(forKey: itemsKey),
      let savedItems = try? JSONDecoder().decode([Item].self, from: data)
    else { return }
    self.itemsArray = savedItems
  }
  
  func updateItem(item: Item) {
    if let index = itemsArray.firstIndex(where: { $0.id == item.id }) {
      itemsArray[index] = item.updateCompletion()
    }
  }
  
  func deleteItem(item: Item) {
    if let index = itemsArray.firstIndex(where: {$0.id == item.id }) {
      itemsArray.remove(at: index)
    }
  }
  
  func saveItems() {
    if let encodedData = try? JSONEncoder().encode(itemsArray) {
      UserDefaults.standard.set(encodedData, forKey: itemsKey)
    }
  }
  
}
