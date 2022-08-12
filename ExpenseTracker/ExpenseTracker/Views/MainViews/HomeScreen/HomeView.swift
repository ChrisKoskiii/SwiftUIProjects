//
//  HomeView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/28/22.
//

import SwiftUI

struct HomeView: View {

  @ObservedObject var coreVM: CoreDataViewModel
  
  var body: some View {
    NavigationView {
      VStack {
        
        MonthlyTotalView(corevm: coreVM)
          
        recentTransactionText
        
        recentExpenseList
        
        Spacer()
        
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          NavigationLink(destination: AddExpenseView(vm: coreVM)) {
            Text("Add Expense")
              .toolBarButtonStyle()
          }
        }
      }
      .background(Color(.secondarySystemBackground))
      .navigationTitle("Overview")
      .navigationBarTitleDisplayMode(.large)
    }
  }
  
  var recentTransactionText: some View {
    HStack {
    Text("Recent transactions:")
      .font(.caption)
      .foregroundColor(.secondary)
      .padding(.leading)
      .padding(.top, 16)
      Spacer()
    }
  }
  
  var recentExpenseList: some View {
    ForEach(coreVM.recentExpenses) { expense in
      RecentExpenseCardView(expenseDate: expense.wrappedDate, expenseTitle: expense.wrappedTitle, expenseVendor: expense.wrappedVendor, expenseCost: expense.cost, expenseCategory: expense.wrappedCategory)
    }
    .onDelete(perform: coreVM.deleteExpense)
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView(coreVM: CoreDataViewModel())
  }
}
