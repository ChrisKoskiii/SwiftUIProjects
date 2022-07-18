//
//  Expenses.swift
//  MyExpense
//
//  Created by Christopher Koski on 7/14/22.
//

import SwiftUI

struct ExpensesView: View {
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(sortDescriptors: []) var expenseItems: FetchedResults<Expense>
  
  var body: some View {
    NavigationView {
      List {
        ForEach(expenseItems, id:\.self) { expense in
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
        .toolbar {
          ToolbarItem {
            EditButton()
          }
        }
      }
    }
  }
  func deleteExpense(at offsets: IndexSet) {
    for index in offsets {
      let expense = expenseItems[index]
      moc.delete(expense)
    }
    do {
      try moc.save()
    } catch {
      print(error.localizedDescription)
    }
  }
}

struct Expenses_Previews: PreviewProvider {
  static var previews: some View {
    ExpensesView()
  }
}
