//
//  ViewModel.swift
//  MyList
//
//  Created by Christopher Koski on 5/5/22.
//

import Foundation

class ViewModel: ObservableObject {
  @Published var itemsArray: [Item] = [
    Item(name: "Take Vitamins"),
    Item(name: "Walk the dog"),
    Item(name: "Take out the trash"),
    Item(name: "Study code"),
    Item(name: "Read for 20 minutes"),
    Item(name: "Take Vitamins"),
    Item(name: "Brush teeth before bed")
  
  ]
  
}
