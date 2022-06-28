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
  @State var hasntSearched = true
  var body: some View {
    NavigationView {
      VStack {
        searchTitle
        mySearchTextField
        searchButton
        if hasntSearched {
          Text("Search for drinks based on an ingredient!")
        } else {
        drinksList
        }
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
      for drink in cocktailAPI.drinks {
        cocktailAPI.fetchDetails(drink.idDrink!)
      }
      hasntSearched = false
    } label: {
      Text("Find!")
        .padding(.all, 4)
      
    }
  }
  
  var drinksList: some View {
    List {
      ForEach(cocktailAPI.drinks, id: \.self) { drink in
        NavigationLink {
          DetailView(drink: drink, cocktailAPI: cocktailAPI)
        } label: {
          HStack {
            AsyncImage(url: URL(string: drink.strDrinkThumb!)) { phase in
              if let image = phase.image {
                image
                  .resizable()
                  .scaledToFit()
                  .frame(width: 100, height: 100)
                  .cornerRadius(20)
                  .padding(.top)
                  .padding(.leading)
                  .padding(.trailing)
              } else if phase.error != nil {
                Color.red
                  .frame(width: 100, height: 100)
              } else {
                Color.blue
                  .frame(width: 100, height: 100)
              }
            }
            Text(drink.strDrink ?? "Drink")
          }
        }
      }
      .listStyle(.inset)
    }
  }
}

struct FindView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
