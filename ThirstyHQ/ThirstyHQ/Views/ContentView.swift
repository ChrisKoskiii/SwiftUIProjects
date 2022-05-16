//
//  ContentView.swift
//  ThirstyHQ
//
//  Created by Christopher Koski on 5/13/22.
//

import SwiftUI

struct ContentView: View {
  
  @StateObject private var cocktailAPI = CocktailDBAPI()
  @State private var textInput = ""
  var body: some View {
    TabView {
      PopularView(cocktailAPI: cocktailAPI)
    }
  }
}






struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
