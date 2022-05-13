//
//  DrinkModel.swift
//  ThirstyHQ
//
//  Created by Christopher Koski on 5/13/22.
//

import Foundation

struct Drinks: Codable, Hashable {
  let drinks: [Drink]
  
  struct Drink: Hashable, Codable {
    let idDrink: String?
    let strDrink: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strDrinkThumb: String?
  }
}

