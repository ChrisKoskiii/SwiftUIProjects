//
//  HomeView.swift
//  SpotifyClone
//
//  Created by Christopher Koski on 7/7/22.
//

import SwiftUI

struct HomeView: View {
  var body: some View {
    ScrollView {
      TopBar()
      RecentGridView()
      ShowsView()
      MetalView()
      RecentlyPlayed()
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
    HomeView()
      .preferredColorScheme(.dark)
  }
}

struct TopBar: View {
  var body: some View {
    VStack {
      HStack {
        Text("Good evening")
          .font(.title2)
          .fontWeight(.bold)
        Spacer()
        Image(systemName: "bell")
          .font(.title2)
          .padding(.horizontal, 8)
        Image(systemName: "clock")
          .font(.title2)
          .padding(.horizontal, 8)
        Image(systemName: "gear")
          .font(.title2)
        
      }
      .padding(8)
    }
  }
}

struct RecentGridView: View {
  var body: some View {
    let columns: [GridItem] = Array(repeating: .init(), count: 2)
    LazyVGrid(columns: columns) {
      ForEach(0..<6) {_ in
        HStack {
          
        }
        .frame(height: 70)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial, in:
                      RoundedRectangle(cornerRadius: 8)
        )
      }
    }
    .padding(.horizontal, 8)
  }
}

struct ShowsView: View {
  var body: some View {
    VStack {
      HStack {
        Text("Your Shows")
          .font(.title2)
          .fontWeight(.bold)
          .padding(.leading, 8)
        Spacer()
      }
      ScrollView(.horizontal) {
        let rows: [GridItem] = Array(repeating: .init(), count: 1)
        LazyHGrid(rows: rows) {
          ForEach(0..<8) {_ in
            VStack {
            }
            .frame(width: 160, height: 160)
            .background(.ultraThinMaterial, in:
                          RoundedRectangle(cornerRadius: 8)
            )
          }
        }
        
      }
      .padding(.horizontal, 8)
    }
  }
}

struct MetalView: View {
  var body: some View {
    VStack {
      HStack {
        Text("High Energy Rock & Metal")
          .font(.title2)
          .fontWeight(.bold)
          .padding(.leading, 8)
        Spacer()
      }
      ScrollView(.horizontal) {
        let rows: [GridItem] = Array(repeating: .init(), count: 1)
        LazyHGrid(rows: rows) {
          ForEach(0..<8) {_ in
            VStack {
            }
            .frame(width: 160, height: 160)
            .background(.ultraThinMaterial, in:
                          RoundedRectangle(cornerRadius: 8)
            )
          }
        }
        
      }
      .padding(.horizontal, 8)
    }
    .padding(.top, 8)
  }
}

struct RecentlyPlayed: View {
  var body: some View {
    VStack {
      HStack {
        Text("Recently Played")
          .font(.title2)
          .fontWeight(.bold)
          .padding(.leading, 8)
        Spacer()
      }
      ScrollView(.horizontal) {
        let rows: [GridItem] = Array(repeating: .init(), count: 1)
        LazyHGrid(rows: rows) {
          ForEach(0..<8) {_ in
            VStack {
            }
            .frame(width: 120, height: 120)
            .background(.ultraThinMaterial, in:
                          RoundedRectangle(cornerRadius: 8)
            )
          }
        }
        
      }
      .padding(.horizontal, 8)
    }
  }
}
