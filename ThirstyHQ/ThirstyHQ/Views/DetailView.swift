//
//  DetailView.swift
//  ThirstyHQ
//
//  Created by Christopher Koski on 5/13/22.
//

import SwiftUI

struct DetailView: View {
  @State var drink: Drinks.Drink
  @ObservedObject var cocktailAPI: CocktailDBAPI
  
  var body: some View {
    ScrollView {
      VStack {
        drinkThumbnail
        ingredients
        directions
      }
    }
    .navigationTitle(drink.strDrink ?? "Cocktail")
    .onAppear() {
      DispatchQueue.main.async {
        if let drinkID = drink.idDrink {
          cocktailAPI.fetchDetails(drinkID)
        }
      }
    }
  }
  
  
  var drinkThumbnail: some View {
    AsyncImage(url: URL(string: drink.strDrinkThumb!)) { phase in
      if let image = phase.image {
        image
          .resizable()
          .scaledToFit()
          .frame(maxWidth:.infinity)
          .cornerRadius(20)
          .background(Color.white)
          .cornerRadius(20)
          .shadow(radius: 3)
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
  }
  
  var ingredients: some View {
    VStack(alignment: .leading) {
      ingredientTitle
      ingredientsList
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.leading)
    .padding(.trailing)
    .padding(.bottom)
    .background(.ultraThinMaterial, in:
                  RoundedRectangle(cornerRadius: 20)
    )
    .background(Color.white)
    .cornerRadius(20)
    .shadow(radius: 3)
    .padding(.leading)
    .padding(.trailing)
  }
  
  var ingredientTitle: some View {
    Text("Ingredients:")
      .font(.title2.bold())
      .padding(.bottom, 4)
  }
  
  var ingredientsList: some View {
    HStack {
      VStack(alignment: .leading, spacing: 4) {
        Text(drink.strIngredient1 ?? "An Ingredient")
        Text(drink.strIngredient2 ?? "An Ingredient")
        Text(drink.strIngredient3 ?? "An Ingredient")
        Text(drink.strIngredient4 ?? "An Ingredient")
        Text(drink.strIngredient5 ?? "An Ingredient")
      }
      .font(.footnote)
      Spacer()
      VStack(alignment: .leading, spacing: 4) {
        Text(drink.strMeasure1 ?? "An Ingredient")
        Text(drink.strMeasure2 ?? "An Ingredient")
        Text(drink.strMeasure3 ?? "An Ingredient")
        Text(drink.strMeasure4 ?? "An Ingredient")
        Text(drink.strMeasure5 ?? "An Ingredient")
      }
      .font(.footnote)
      .frame(minWidth: 200)
    }
  }
  
  var directions: some View {
    VStack(alignment: .leading) {
      Text("Directions:")
        .font(.title2.bold())
        .padding(.bottom, 4)
      Text(drink.strInstructions ?? "No Instructions")
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.leading)
    .padding(.trailing)
    .padding(.bottom)
    .background(.ultraThinMaterial, in:
                  RoundedRectangle(cornerRadius: 20)
    )
    .background(Color.white)
    .cornerRadius(20)
    .shadow(radius: 3)
    .padding()
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
