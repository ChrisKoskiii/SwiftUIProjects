//
//  SettingsView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/29/22.
//

import SwiftUI

struct SettingsView: View {
  @State private var opacity = 0.0
  @ObservedObject var corevm: CoreDataViewModel
  
  var body: some View {
    ZStack {
      BackgroundView()
      List {
        
        ForEach(corevm.savedExpenses) { expense in
          
          NavigationLink(destination: DetailExpenseView(vm: corevm, detailExpense: expense, titleText: expense.wrappedTitle, costText: expense.cost, vendorText: expense.wrappedVendor, categoryText: expense.wrappedCategory, dateValue: expense.wrappedDate, imageData: expense.receipt)) {
            
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
              Text("$" + String(expense.cost))
                .font(.title3)
            }
            
          }
        }
        .onDelete(perform: corevm.deleteExpense)
      }
      .listStyle(.plain)
    }
    .onAppear {
      DispatchQueue.main.async {
        withAnimation {
          opacity = 1.0
        }
      }
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView(corevm: CoreDataViewModel())
  }
}
