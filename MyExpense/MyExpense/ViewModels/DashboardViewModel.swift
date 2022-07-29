//
//  DashboardViewModel.swift
//  MyExpense
//
//  Created by Christopher Koski on 7/27/22.
//

import Foundation
import CoreData

class DashboardViewModel: ObservableObject {
  private (set) var context: NSManagedObjectContext
  
  init(context: NSManagedObjectContext) {
    self.context = context
  }
}
