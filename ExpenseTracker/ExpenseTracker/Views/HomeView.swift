//
//  HomeView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/28/22.
//

import SwiftUI

struct HomeView: View {
  @ObservedObject var vm: CoreDataViewModel

  @State var opacity = 0.0
  @State var hasScrolled = false
  var body: some View {
    NavigationView {
      ZStack {
        BackgroundView()
        VStack {
          MonthlyTotalView()
          HStack {
            Text("Recent transactions:")
              .font(.caption)
              .padding(.leading)
              .padding(.top, 16)
            Spacer()
            
          }
          ForEach(vm.savedExpenses) { expense in
            RecentExpenseCardView(expenseDate: expense.wrappedDate, expenseTitle: expense.wrappedTitle, expenseVendor: expense.wrappedVendor, expenseCost: expense.cost, expenseCategory: expense.wrappedCategory)
          }
          .onDelete(perform: vm.deleteExpense)
          Spacer()
        }
        .opacity(opacity)
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            NavigationLink(destination: AddExpenseView(vm: vm)) {
              Text("Add Expense")
                .font(.footnote)
                .padding(.horizontal)
                .padding(.vertical, 4)
                .foregroundColor(.white)
                .background(.cyan)
                .clipShape(Capsule())
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
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView(vm: CoreDataViewModel())
  }
}
