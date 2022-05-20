//
//  FindView.swift
//  ThirstyHQ
//
//  Created by Christopher Koski on 5/16/22.
//

import SwiftUI

struct FindView: View {
  @State private var searchInput = ""
  @ObservedObject var cocktailAPI: CocktailDBAPI
  
  var body: some View {
    NavigationView {
      VStack {
        searchTitle
        mySearchTextField
        searchButton
        drinksList
      }
      .navigationBarHidden(true)
    }
    .tabItem {
      Label("Find", systemImage: "magnifyingglass")
    }
  }
  
  var searchTitle: some View {
    Text("Search by Ingredient (ex. Gin)")
      .font(.footnote)
  }
  
  var mySearchTextField: some View {
    TextField("Search here", text: $searchInput)
      .padding()
      .background(.ultraThinMaterial, in:
                    RoundedRectangle(cornerRadius: 20)
      )
      .padding(.leading)
      .padding(.trailing)
  }
  
  var searchButton: some View {
    Button {
      cocktailAPI.searchIngredient(text: searchInput)
    } label: {
      Text("Find!")
        .padding(.all, 4)

    }
  }
  
  var drinksList: some View {
    List {
      ForEach(cocktailAPI.drinks, id: \.self) { drink in
        Text(drink.strDrink ?? "Dirnk")
      }
    }
    .listStyle(.inset)
  }
}

struct FindView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
