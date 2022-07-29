//
//  AddExpenseView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/28/22.
//

import SwiftUI

struct AddExpenseView: View {
  @Environment(\.presentationMode) var presentationMode
  
  @ObservedObject var vm: CoreDataViewModel

  @State var titleText: String = ""
  @State var costText: Double = 0.0
  @State var vendorText: String = ""
  @State var categoryText: String = ""
  
  @State var showingScanner = false
  
  var body: some View {
    VStack(spacing: 10) {
      
      TextField("Enter title", text: $titleText)
        .textfieldStyle()
      TextField("Enter cost", value: $costText, format: .number)
        .textfieldStyle()
      TextField("Enter vendor", text: $vendorText)
        .textfieldStyle()
      TextField("Enter category", text: $categoryText)
        .textfieldStyle()
      
      Button {
        showingScanner = true
      } label: {
        HStack {
          Image(systemName: "doc.text.viewfinder")
            .renderingMode(.template)
            .foregroundColor(.white)
          Text("Scan")
            .foregroundColor(.white)
        }
        .buttonStyle()
      }
      
      
      
      Button {
        vm.addExpense(title: titleText,
                      cost: costText,
                      vendor: vendorText,
                      category: categoryText)
        presentationMode.wrappedValue.dismiss()
      } label: {
        Text("Add Expense")
          .buttonStyle()
      }
      
      List {
        ForEach(vm.savedExpenses) { expense in
          Text(expense.title ?? "")
            .onTapGesture {
              vm.updateExpense(entity: expense)
            }
        }
        .onDelete(perform: vm.deleteExpense)
        
      }
      .listStyle(.plain)
      
    }
    .background(BackgroundView())
    .navigationTitle("Add expense")
  }
}


struct AddExpenseView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      AddExpenseView(vm: CoreDataViewModel())
    }
  }
}
