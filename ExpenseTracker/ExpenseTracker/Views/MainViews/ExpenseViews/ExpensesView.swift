//
//  ExpensesView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/29/22.
//

import SwiftUI

struct ExpensesView: View {
  
  @ObservedObject var corevm: CoreDataViewModel
  
  @State private var opacity = 0.0
  
  var formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.maximumFractionDigits = 2
    return formatter
  }()
  
  var body: some View {
    ZStack {
      expenseList
    }
    .navigationTitle("All Expenses")
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        NavigationLink(destination: AddExpenseView(vm: corevm)) {
          Text("Add Expense")
            .toolBarButtonStyle()
        }
      }
    }
  }
  
  var expenseList: some View {
    List {
      
      ForEach(corevm.savedExpenses) { expense in
        
        NavigationLink(destination: DetailExpenseView(vm: corevm, detailExpense: expense, titleText: expense.wrappedTitle, costText: expense.cost, vendorText: expense.wrappedVendor, categoryText: expense.wrappedCategory, sentDate: expense.wrappedDate, imageData: expense.receipt)) {
          
          HStack {
            Text(expense.wrappedDate.formatDate())
            
            VStack(alignment: .leading) {
              Text(expense.wrappedTitle)
              Text(expense.wrappedVendor)
                .font(.footnote)
              Text(expense.wrappedCategory)
                .font(.footnote)
            }
            
            Spacer()
            let costString = formatter.string(from: NSNumber(value: expense.cost))!
            Text(costString)
              .font(.title3)
          }
          
        }
      }
      .onDelete(perform: corevm.deleteExpense)
    }
    .listStyle(.plain)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        EditButton()
      }
    }
  }
}

struct ExpensesView_Previews: PreviewProvider {
  static var previews: some View {
    ExpensesView(corevm: CoreDataViewModel())
  }
}
