//
//  ContentView.swift
//  CocktailCreator
//
//  Created by Christopher Koski on 5/11/22.
//

import SwiftUI

struct ContentView: View {
  
  var cocktails = [
    "Old Fashioned",
    "Margharita",
    "Manhattan",
    "Martini",
    "Moscow Mule",
  ]
  var body: some View {
    ZStack {
      Color.red
        .ignoresSafeArea()
      VStack {
        TopToolBar()
        Spacer()
        List {
          ForEach(cocktails, id: \.self) { cocktail in
            Text(cocktail)
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

struct TopToolBar: View {
  @State var searchText = ""
  var body: some View {
    HStack(spacing: 8) {
      TextField("Search", text: $searchText)
        .multilineTextAlignment(.leading)
        .background(.ultraThinMaterial)
        .padding()
      Image(systemName: "magnifyingglass")
        .font(.title)
        .padding(.leading)
      Spacer()
    }
  }
}
