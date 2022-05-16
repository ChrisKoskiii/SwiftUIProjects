//
//  PopularView.swift
//  ThirstyHQ
//
//  Created by Christopher Koski on 5/16/22.
//

import SwiftUI

struct PopularView: View {
  @ObservedObject var cocktailAPI: CocktailDBAPI
    var body: some View {
      NavigationView {
        ZStack {
          VStack {
            ScrollView {
              DrinkGridView(cocktailAPI: cocktailAPI)
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
      .tabItem {
        Label("Popular", systemImage: "star")
      }
    }
}

struct DrinkGridView: View {
  @ObservedObject var cocktailAPI: CocktailDBAPI
  var body: some View {
    let columns: [GridItem] = Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
    LazyVGrid(columns: columns) {
      ForEach (cocktailAPI.drinks, id: \.self) { drink in
        DrinkCellView(drink: drink)
      }
    }
  }
}

struct DrinkCellView: View {
  @State var drink: Drinks.Drink
  var body: some View {
    
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
            .minimumScaleFactor(0.01)
            .padding(.leading, 8)
            .padding(.trailing, 8)
            .foregroundStyle(.linearGradient(colors: [.primary, .primary.opacity(0.7)], startPoint: .leading, endPoint: .trailing))
        }
        .background(.ultraThinMaterial, in:
                      RoundedRectangle(cornerRadius: 20 )
        )
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 3)
      }
    }
  }
}

struct PopularView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
