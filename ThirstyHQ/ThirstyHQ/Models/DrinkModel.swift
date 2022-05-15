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
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strDrinkThumb: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strInstructions: String?
  }
}

