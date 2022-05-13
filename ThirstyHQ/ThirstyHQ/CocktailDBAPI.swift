//
//  CocktailDBAPI.swift
//  ThirstyHQ
//
//  Created by Christopher Koski on 5/13/22.
//

import Foundation

class CocktailDBAPI: ObservableObject {
  
  @Published var drinks: [Drinks.Drink] = []
  
  let apiString = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=a"
  
  func getDrinks() {
    fetchData(url: apiString)
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
