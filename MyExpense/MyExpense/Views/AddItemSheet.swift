//
//  AddItemSheet.swift
//  MyExpense
//
//  Created by Christopher Koski on 7/15/22.
//

import SwiftUI

struct AddItemSheet: View {
  @Environment(\.dismiss) var dismiss
  @Environment(\.managedObjectContext) var moc
  
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
          HStack {
            TextField("", text: $category)
            NavigationLink {
              //store history
            } label : {
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
          addExpense()
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
  func addExpense() {
    if checkEmpties() {
      let newExpense = Expense(context: moc)
      newExpense.title = expenseName
      newExpense.price = price
      newExpense.date = Date()
      newExpense.vendor = Vendor(context: moc)
      newExpense.vendor.name = vendorName
      newExpense.category = Category(context: moc)
      newExpense.category.name = category
      
      try? moc.save()
      dismiss()
    }
  }
  
  func checkEmpties() -> Bool {
    if expenseName.count == 0 || price <= 0.0 || category.count == 0 || vendorName.count == 0 {
      //present eror
      return false
    }
    return true
  }
}

struct AddItemSheet_Previews: PreviewProvider {
  static var previews: some View {
    AddItemSheet()
  }
}

