//
//  ExpensesView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/29/22.
//

import SwiftUI

struct ExpensesView: View {
  @ObservedObject var vm: CoreDataViewModel
  @State private var opacity = 0.0
  var body: some View {
    NavigationView {
      ZStack {
        BackgroundView()
        List {
          ForEach(vm.savedExpenses) { expense in
            NavigationLink(destination: DetailExpenseView(vm: vm, detailExpense: expense, titleText: expense.wrappedTitle, costText: expense.cost, vendorText: expense.wrappedVendor, categoryText: expense.wrappedCategory, sentDate: expense.wrappedDate)) {
              HStack {
                Text(expense.wrappedDate)
                VStack(alignment: .leading) {
                  Text(expense.wrappedTitle)
                  Text(expense.wrappedVendor)
                    .font(.footnote)
                  Text(expense.wrappedCategory)
                    .font(.footnote)
                }
                Spacer()
                Text("$" + String(expense.cost))
                  .font(.title3)
              }
            }
          }
          .onDelete(perform: vm.deleteExpense)
        }
        .listStyle(.plain)
        .padding() 
      }
      .navigationTitle("All Expenses")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          NavigationLink(destination: AddExpenseView(vm: vm)) {
            Text("Add Expense")
              .font(.footnote)
              .padding(.horizontal)
              .padding(.vertical, 4)
              .foregroundColor(.white)
              .background(.blue)
              .clipShape(Capsule())
          }
        }
      }
    }
  }
}

struct ExpensesView_Previews: PreviewProvider {
  static var previews: some View {
    ExpensesView(vm: CoreDataViewModel())
  }
}
