//
//  CategoryListView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 8/18/22.
//

import SwiftUI

struct CategoryListView: View {
  
  @ObservedObject var expensesVM: ExpensesViewModel
  @ObservedObject var coreVM: CoreDataViewModel
  
  @State var detailExpenseCategory: String?
  
  var body: some View {
    if detailExpenseCategory != nil {
      ItemList(items: expensesVM.categories, selectedItem: $detailExpenseCategory)
        .navigationTitle("Categories")
        .navigationBarTitleDisplayMode(.inline)
    } else {
      ItemList(items: expensesVM.categories, selectedItem: $expensesVM.selectedCategory)
        .navigationTitle("Categories")
        .navigationBarTitleDisplayMode(.inline)
    }
  }
}

struct CategoryListView_Previews: PreviewProvider {
  
  static var previews: some View {
    NavigationView {
      ItemList(items: [
        "Professional Fees",
        "Service Fees",
        "Equipment",
        "Uniforms",
        "Licenses"
      ], selectedItem: .constant("Constant"))
    }
  }
}
