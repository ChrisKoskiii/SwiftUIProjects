//
//  DataModels.swift
//  MyExpense
//
//  Created by Christopher Koski on 7/26/22.
//

import Foundation

struct ExpenseModel {
  var title: String
  var date: Date
  var category: CategoryModel
  var vendor: VendorModel
  var price: Double
}

struct CategoryModel {
  var id: UUID
  var name: String
}

struct VendorModel {
  var id: UUID
  var name: String
}
