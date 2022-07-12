//
//  ContentView.swift
//  SpotifyClone
//
//  Created by Christopher Koski on 7/7/22.
//

import SwiftUI

struct MainView: View {
  var body: some View {
    TabView {
      HomeView()
        .tabItem {
          Image(systemName: "house")
        }
      SearchView()
        .tabItem {
          Image(systemName: "magnifyingglass")
        }
      LibraryView()
        .tabItem {
          Image(systemName: "books.vertical")
        }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
    MainView()
      .preferredColorScheme(.dark)
  }
}
