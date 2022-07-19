//
//  Expenses.swift
//  MyExpense
//
//  Created by Christopher Koski on 7/14/22.
//

import SwiftUI
import ElegantCalendar

enum viewChoice: String, CaseIterable {
  case list = "By Date"
  case calendar = "By Category"
}
struct chosenView: View {
  var selectedView: viewChoice
  
  var body: some View {
    switch selectedView {
    case .list:
      expenseList()
    case .calendar:
      Text("hello")
    }
  }
}


struct ExpensesView: View {
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(sortDescriptors: []) var expenseItems: FetchedResults<Expense>
  
  @State private var selectedPicker: viewChoice = .list
  
  var body: some View {
    NavigationView {
      VStack {
        Picker("Choose View", selection: $selectedPicker) {
          ForEach(viewChoice.allCases, id: \.self) {
            Text($0.rawValue)
          }
        }
        .pickerStyle(.segmented)
        .padding()
        expenseList()
      }
      .navigationTitle("All expenses")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem {
          EditButton()
        }
      }
    }
  }
}

struct expenseList: View {
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(sortDescriptors: []) var expenseItems: FetchedResults<Expense>
  
  var body: some View {
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

struct ExpenseCalendarView: View {
  
  static let startDate = Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (-30 * 36)))
  static let endDate = Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (30 * 36)))

  @ObservedObject var calendarManager = ElegantCalendarManager(
      configuration: CalendarConfiguration(startDate: startDate,
                                           endDate: endDate))

  var body: some View {
      ElegantCalendarView(calendarManager: calendarManager)
  }
}

struct Expenses_Previews: PreviewProvider {
  static var previews: some View {
    ExpensesView()
  }
}
