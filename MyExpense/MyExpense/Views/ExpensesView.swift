//
//  Expenses.swift
//  MyExpense
//
//  Created by Christopher Koski on 7/14/22.
//

import SwiftUI

enum viewChoice: String, CaseIterable {
  case list = "By Date"
  case calendar = "By Category"
}
struct chosenView: View {
  @ObservedObject var dataVM: DataController
  var selectedView: viewChoice
  
  var body: some View {
    switch selectedView {
    case .list:
      expenseList(dataVM: dataVM)
    case .calendar:
      Text("hello")
    }
  }
}


struct ExpensesView: View {
  @ObservedObject var dataVM: DataController
  
  @State private var selectedPicker: viewChoice = .list
  
  var body: some View {
    NavigationView {
      VStack {
        Picker("Choose View", selection: $selectedPicker) {
          ForEach(viewChoice.allCases, id: \.self) {
            Text($0.rawValue)
          }
        }
        .pickerStyle(.segmented)
        .padding()
        expenseList(dataVM: dataVM)
      }
      .navigationTitle("All expenses")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem {
          EditButton()
        }
      }
    }
  }
}

struct expenseList: View {
  
  @ObservedObject var dataVM: DataController
  var body: some View {
    List {
      ForEach(dataVM.savedExpenses, id:\.self) { expense in
        HStack {
          VStack(alignment: .leading) {
            Text(expense.wrappedTitle)
            Text(expense.category.wrappedName)
              .font(.caption)
            Text(String(expense.formattedDate))
              .font(.caption2)
          }
          Spacer()
          VStack(alignment: .trailing) {
            Text(expense.formattedPrice)
            Text(expense.vendor.wrappedName)
            
              .font(.caption2)
            Spacer()
          }
        }
      }
      .onDelete(perform: deleteExpense)
    }
  }
  
  func deleteExpense(at offsets: IndexSet) {
    for index in offsets {
      let expense = dataVM.savedExpenses[index]
      dataVM.container.viewContext.delete(expense)
    }
    dataVM.saveData()
  }
}

struct Expenses_Previews: PreviewProvider {
  static var previews: some View {
    ExpensesView(dataVM: DataController())
  }
}
