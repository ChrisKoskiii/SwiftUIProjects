//
//  ExpensesView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/29/22.
//

import SwiftUI

struct ExpensesView: View {
  @ObservedObject var vm: CoreDataViewModel
  
  var body: some View {
    NavigationView {
      ZStack {
        BackgroundView()
        List {
          ForEach(vm.savedExpenses) { expense in
            Text(expense.title ?? "")
          }
          .onDelete(perform: vm.deleteExpense)
        }
        .listStyle(.plain)
      }
    }
  }
}

struct ExpensesView_Previews: PreviewProvider {
  static var previews: some View {
    ExpensesView(vm: CoreDataViewModel())
  }
}
