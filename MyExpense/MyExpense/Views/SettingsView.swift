//
//  SettingsView.swift
//  MyExpense
//
//  Created by Christopher Koski on 7/14/22.
//

import SwiftUI

struct SettingsView: View {
  @State var isShowingScanner = false
  var body: some View {
    Button("Start scan") {
      isShowingScanner = true
    }
    .sheet(isPresented: $isShowingScanner) {
      DocumentScanner()
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
