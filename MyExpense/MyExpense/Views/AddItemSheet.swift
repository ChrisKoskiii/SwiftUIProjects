//
//  AddItemSheet.swift
//  MyExpense
//
//  Created by Christopher Koski on 7/15/22.
//

import SwiftUI

struct AddItemSheet: View {
  @State var price = 0.0
  @State var expenseName = ""
  @State var category = ""
  @State var vendorName = ""
  var body: some View {
    NavigationView {
      List {
        Section {
          TextField("", value: $price, format: .currency(code: "USD"))
        } header: {
          Text("What did it cost?")
        }
        Section {
          TextField("", text: $expenseName)
        } header: {
          Text("What is it for?")
        }
        Section {
          Picker("Category", selection: $category) {
            ForEach(1..<5) {_ in
              Text("Category")
            }
          }
        } header: {
          Text("What category?")
        }
        Section {
          HStack {
            TextField("", text: $vendorName)
            NavigationLink {
              //store history
            } label : {
            }
          }
        } header: {
          Text("Where did you buy?")
        }
        Button{
          //add item
        } label: {
          HStack {
            Spacer()
            Text("Add Item")
            Spacer()
          }
        }
        .font(.title2)
        .foregroundStyle(.linearGradient(colors: [.blue, .blue.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
      }
      .navigationTitle("Add an expense")
    }
  }
}

struct AddItemSheet_Previews: PreviewProvider {
  static var previews: some View {
    AddItemSheet()
  }
}

