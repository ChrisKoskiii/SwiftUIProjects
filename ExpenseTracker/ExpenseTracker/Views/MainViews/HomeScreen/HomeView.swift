//
//  HomeView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/28/22.
//

import SwiftUI

struct HomeView: View {
  
  @ObservedObject var coreVM: CoreDataViewModel
  @ObservedObject var expensesVM: ExpensesViewModel
  
  @State private var opacity = 0.0
  
  var body: some View {
    NavigationView {
      VStack {
        
        MonthlyTotalView(coreVM: coreVM)
        
        recentTransactionText
        
        recentExpenseList
        
        Spacer()
        
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          NavigationLink(destination: AddExpenseView(coreVM: coreVM, expensesVM: expensesVM)) {
            ZStack {
              Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(Color.brandPrimary)
              Image(systemName: "plus")
                .foregroundColor(.white)
            }
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
      Text("Recent activity:")
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
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView(coreVM: CoreDataViewModel(), expensesVM: ExpensesViewModel())
  }
}
