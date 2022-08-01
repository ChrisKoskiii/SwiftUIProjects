//
//  HomeView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/28/22.
//

import SwiftUI

struct HomeView: View {
  @ObservedObject var corevm: CoreDataViewModel
  
  @State var opacity = 0.0
  @State var hasScrolled = false
  var body: some View {
    NavigationView {
      
      ZStack {
        
        BackgroundView()
        
        VStack {
          
          MonthlyTotalView()
          
          HStack {
            
            recentTransactionText
            Spacer()
          }
          
          recentExpenseList
          Spacer()
          
        }
        .opacity(opacity)
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            NavigationLink(destination: AddExpenseView(vm: corevm)) {
              Text("Add Expense")
                .toolBarButtonStyle()
            }
          }
        }
        
        .onAppear {
          DispatchQueue.main.async {
            withAnimation {
              opacity = 1.0
            }
          }
        }
      }
      .navigationTitle("ExpenseTracker")
    }
  }
  
  var recentTransactionText: some View {
    Text("Recent transactions:")
      .font(.caption)
      .padding(.leading)
      .padding(.top, 16)
  }
  
  var recentExpenseList: some View {
    ForEach(corevm.recentExpenses) { expense in
      RecentExpenseCardView(expenseDate: expense.wrappedDate, expenseTitle: expense.wrappedTitle, expenseVendor: expense.wrappedVendor, expenseCost: expense.cost, expenseCategory: expense.wrappedCategory)
    }
    .onDelete(perform: corevm.deleteExpense)
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView(corevm: CoreDataViewModel())
  }
}
