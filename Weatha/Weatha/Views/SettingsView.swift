//
//  SettingsView.swift
//  Weatha
//
//  Created by Christopher Koski on 3/26/22.
//

import SwiftUI

struct SettingsView: View {
  var body: some View {
    ZStack {
      BackgroundGradient()
      Text("Settings")
        .foregroundColor(Color("TextColor"))
    }
    .tabItem {
      Label("Settings", systemImage: "gear")
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
