//
//  ContentView.swift
//  SwiftUIAPICalls
//
//  Created by Christopher Koski on 3/24/22.
//

import SwiftUI
import RickMortySwiftApi

struct ContentView: View {
  
  let rmClient = RMClient()
  
  var body: some View {
    Text("Hi")
      .onAppear() {
        testRM()
      }
  }
  
  func testRM () {
    
    var allChar: Welcome?
    allChar = rmClient.character().getAllCharacters()
      .sink(receiveCompletion: { _ in }, receiveValue: { characters in
        characters.forEach() { print ($0.name) }
      })
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
