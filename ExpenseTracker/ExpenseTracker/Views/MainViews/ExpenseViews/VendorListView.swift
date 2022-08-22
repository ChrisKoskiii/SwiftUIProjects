//
//  VendorListView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 8/18/22.
//

import SwiftUI

struct VendorListView: View {
  @EnvironmentObject var coreVM: CoreDataViewModel
  
  @ObservedObject var expensesVM: ExpensesViewModel
  
  var body: some View {
    ItemList(items: expensesVM.vendors, selectedItem: $expensesVM.selectedVendor)
      .navigationTitle("Vendors")
      .navigationBarTitleDisplayMode(.inline)
  }
}

struct VendorListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ItemList(items: [
        "Home-Depot",
        "Mr. Tax Man",
        "Ace Hardware",
        "EquipmentAndStuff.com",
        "Palm Beach County"
      ], selectedItem: .constant("Constant"))
    }
  }
}
