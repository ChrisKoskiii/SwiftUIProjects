//
//  ContentView.swift
//  ThirstyHQ
//
//  Created by Christopher Koski on 5/13/22.
//

import SwiftUI

struct ContentView: View {
  
  var drinks = ["old fashioned", "margarhita", "manhattan", "gin & tonic", "white russian"]
  
  @StateObject private var cocktailAPI = CocktailDBAPI()
  
  var body: some View {
    
    NavigationView {
      ZStack {
        
        VStack {
          let columns: [GridItem] = Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
          
          ScrollView {
            LazyVGrid(columns: columns) {
              ForEach (cocktailAPI.drinks, id: \.self) { drink in
                VStack(alignment: .leading, spacing: 8) {
                  NavigationLink {
                    DetailView(drink: drink)
                  } label : {
                    VStack {
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
                        }
                      }
                      Text(drink.strDrink ?? "Cocktail")
                        .font(.title3.bold())
                        .foregroundStyle(.linearGradient(colors: [.primary, .primary.opacity(0.7)], startPoint: .leading, endPoint: .trailing))
                    }
                    .background(.ultraThinMaterial, in:
                                  RoundedRectangle(cornerRadius: 20 )
                    )
                  }
                }
              }
            }
          }
        }
        .navigationTitle("Popular")
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Search") {
              cocktailAPI.getDrinks()
            }
          }
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
