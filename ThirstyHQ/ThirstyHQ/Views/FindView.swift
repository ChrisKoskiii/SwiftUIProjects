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
        Text("Search by Ingredient (ex. Gin)")
          .font(.footnote)
        TextField("Search here", text: $searchInput)
          .padding()
          .background(.ultraThinMaterial, in:
                        RoundedRectangle(cornerRadius: 20)
          )
          .padding(.leading)
          .padding(.trailing)
        Button {
          //search
        } label: {
          Text("Find!")
            .padding(.all, 4)

        }
        List {
          ForEach(cocktailAPI.drinks, id: \.self) { drink in
            Text(drink.strDrink ?? "Dirnk")
          }
        }
        .listStyle(.inset)
      }
      .navigationBarHidden(true)
    }
    .tabItem {
      Label("Find", systemImage: "magnifyingglass")
    }
  }
}

struct FindView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
