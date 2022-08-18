//
//  ItemList.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 8/18/22.
//

import SwiftUI

struct ItemList: View {
  @Environment(\.presentationMode) var presentationMode
  
  @State var items: [String]
  @State var selectedChoice = "Alphabetical"
  @Binding var selectedItem: String?
  
  var sortChoices = ["Alphabetical", "Recently Used"]
  
  var body: some View {
    VStack {
      Picker("Full Report or Summary", selection: $selectedChoice) {
        ForEach(sortChoices, id: \.self) {
          Text($0)
        }
      }
      .pickerStyle(.segmented)
      .padding(.horizontal)
      List {
        ForEach(items, id: \.self) { item in
          Button {
            selectedItem = item
            presentationMode.wrappedValue.dismiss()
          } label: {
            Text(item)
          }
        }
      }
      .listStyle(.plain)
    }
    .background(Color(.secondarySystemBackground))
  }
}

struct ItemList_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ItemList(items: [
          "Professional Fees",
          "Service Fees",
          "Equipment",
          "Uniforms",
          "Licenses"
      ], selectedItem: .constant("Constant"))
    }
  }
}
