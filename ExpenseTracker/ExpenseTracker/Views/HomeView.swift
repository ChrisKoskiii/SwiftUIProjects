//
//  HomeView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/28/22.
//

import SwiftUI

struct HomeView: View {
  @ObservedObject var vm: CoreDataViewModel
    var body: some View {
      NavigationView {
        ZStack {
          BackgroundView()
          VStack {
            ForEach(vm.savedExpenses) { expense in
              RecentExpenseCardView(expenseTitle: expense.title ?? "", expenseVendor: expense.vendor ?? "", expenseCost: expense.cost)
            }
            .onDelete(perform: vm.deleteExpense)
            Spacer()
          }
          
          .navigationTitle("ExpenseTracker")
          .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
              NavigationLink(destination: AddExpenseView(vm: vm)) {
                Label("Add Expense", systemImage: "plus")
              }
            }
          }
        }
      }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
      HomeView(vm: CoreDataViewModel())
    }
}
