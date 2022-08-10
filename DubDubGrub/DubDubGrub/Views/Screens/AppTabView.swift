//
//  AppTabView.swift
//  DubDubGrub
//
//  Created by Christopher Koski on 8/9/22.
//

import SwiftUI

struct AppTabView: View {
  var body: some View {
    TabView {
      LocationMapView()
        .tabItem {
          Label("Map", systemImage: "map")
        }
      LocationListView()
        .tabItem {
          Label("Locations", systemImage: "building")
        }
      NavigationView {
        Profile()
      }
      .tabItem {
        Label("Profile", systemImage: "person")
      }
    }
    .accentColor(.brandPrimary)
  }
}

struct AppTabView_Previews: PreviewProvider {
  static var previews: some View {
    AppTabView()
  }
}
