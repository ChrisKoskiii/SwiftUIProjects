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
  
  @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var vendors: FetchedResults<Vendor>
  
  @State private var price = 0.0
  @State private var expenseName = ""
  @State private var categoryName = ""
  @State private var newCategoryName = ""
  @State private var vendorName = ""
  @State private var expenseDate = Date()
  @State private var categoriesArray: [String] = []
  @State private var vendorsArray: [String] = []
  @State private var cameraIsPresented = false
  @State private var showScanner = false
  @State private var isRecognizing = false
  
  var body: some View {
    NavigationView {
      VStack {
        Form {
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
            HStack {
              TextField("Category", text: $categoryName)
              Picker("", selection: $categoryName) {
                ForEach(categoriesArray, id: \.self) {
                  Text($0)
                }
              }
              .pickerStyle(.menu)
            }
          } header: {
            Text("What category?")
          }
          Section {
            HStack {
              TextField("Vendor", text: $vendorName)
              Picker("", selection: $vendorName) {
                ForEach(vendorsArray, id: \.self) {
                  Text($0)
                }
              }
              .pickerStyle(.menu)
            }
          } header: {
            Text("Where did you buy?")
          }
          ScannerSection()
        }
        Button("Add Item"){
          addExpense()
        }
        .font(.title2)
        .foregroundStyle(.linearGradient(colors: [.blue, .blue.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
      }
    }
    .navigationTitle("Add an expense")
    .navigationBarTitleDisplayMode(.inline)
    .onAppear {
      getCategories()
      getVendors()
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
  
  func getCategories() {
    if categoriesArray.isEmpty {
      for category in categories {
        categoriesArray.append(category.wrappedName)
        categoriesArray = categoriesArray.sorted { $0 > $1 }
      }
    } else { return }
  }
  
  func getVendors() {
    if vendorsArray.isEmpty {
      for vendor in vendors {
        vendorsArray.append(vendor.wrappedName)
        vendorsArray = vendorsArray.sorted { $0 > $1 }
      }
    } else { return }
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


struct ScannerSection: View {
  var body: some View {
    VStack {
      HStack {
        Spacer()
        HStack {
          Image(systemName: "doc.text.viewfinder")
            .renderingMode(.template)
            .foregroundColor(.white)
          
          Text("Scan")
            .foregroundColor(.white)
        }
        .padding(.horizontal, 16)
        .frame(height: 36)
        .background(Color(UIColor.systemIndigo))
        .cornerRadius(18)
        Spacer()
      }
    }
  }
}
