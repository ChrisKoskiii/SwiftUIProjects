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
  @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var categories: FetchedResults<Category>
  
  @State var price = 0.0
  @State var expenseName = ""
  @State var categoryName = ""
  @State var vendorName = ""
  @State var expenseDate = Date()
  
  var body: some View {
    NavigationView {
      List {
        Section {
          DatePicker("Date", selection: $expenseDate, displayedComponents: [.date])
        }
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
          VStack {
            Picker("Category", selection: $categoryName) {
              Button("Add New") { }
              ForEach(categories) { category in
                Text(category.wrappedName)
              }
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
      newExpense.date = expenseDate
      newExpense.vendor = Vendor(context: moc)
      newExpense.vendor.name = vendorName
      newExpense.category = Category(context: moc)
      newExpense.category.name = categoryName
      
      try? moc.save()
      dismiss()
    }
  }
  
  func checkEmpties() -> Bool {
    if expenseName.count == 0 || price <= 0.0 || categoryName.count == 0 || vendorName.count == 0 {
      //present eror
      return false
    }
    return true
  }
}

struct CategoryList: View {
  @Environment(\.dismiss) var dismiss
  @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var categories: FetchedResults<Category>
  @Binding var categoryName: String
  
  var body: some View {
    ForEach(categories) { category in
      Text(category.wrappedName)
        .onTapGesture {
          categoryName = category.wrappedName
          dismiss()
        }
    }
  }
}

struct AddItemSheet_Previews: PreviewProvider {
  static var previews: some View {
    AddItemSheet()
  }
}

