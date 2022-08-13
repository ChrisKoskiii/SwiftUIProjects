//
//  SettingsView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/29/22.
//

import SwiftUI

struct SettingsView: View {
  @State private var opacity = 0.0
  @ObservedObject var corevm: CoreDataViewModel
  
  var body: some View {
    Text("Settings")
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView(corevm: CoreDataViewModel())
  }
}
