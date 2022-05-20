//
//  CocktailDBAPI.swift
//  ThirstyHQ
//
//  Created by Christopher Koski on 5/13/22.
//

import Foundation

class CocktailDBAPI: ObservableObject {
  
  @Published var drinks: [Drinks.Drink] = []
  
  let apiString = "https://www.thecocktaildb.com/api/json/v2/9973533/popular.php"
  
  func getDrinks() {
    fetchData(url: apiString)
  }
  
  func searchIngredient(text: String) {
    let url = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=" + "\(text)"
    fetchData(url: url)
    print(url)
  }
  
  func fetchData(url: String) {
    guard let url = URL(string: url) else {
      print("Invalid URL")
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
      guard let data = data, error == nil else {
        return
      }
      
      do {
        if let drinks = try JSONDecoder().decode(Drinks?.self, from: data) {
          DispatchQueue.main.async {
            self?.drinks = drinks.drinks
            print(drinks)
          }
        }
      } catch {
        print(error)
      }
    }
    task.resume()
  }
}
