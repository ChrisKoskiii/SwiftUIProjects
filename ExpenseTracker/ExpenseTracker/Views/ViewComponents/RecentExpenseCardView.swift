//
//  RecentExpenseCardView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/28/22.
//

import SwiftUI

struct RecentExpenseCardView: View {
  var expenseDate: String
  var expenseTitle: String
  var expenseVendor: String
  var expenseCost: Double
  var expenseCategory: String
  
  var body: some View {
    ZStack {
      HStack(spacing: 0) {
        Group {
          HStack(spacing: 0) {
            Text(expenseDate)
              .fontWeight(.bold)
              .padding(.leading)
            VStack(alignment: .leading, spacing: 0) {
              Text(expenseTitle)
                .font(.headline)
                .padding(.leading)
                .padding(.top, 4)
              Text(expenseVendor)
                .font(.footnote)
                .padding(.leading)
              Text(expenseCategory)
                .font(.footnote)
                .padding(.leading)
                .padding(.bottom, 4)
            }
            Spacer()
              Text("$"+String(expenseCost))
                .font(.title2)
                .fontWeight(.bold)
                .padding(.trailing)
          }
          .background(.ultraThinMaterial, in: RoundedRectangle(
            cornerRadius: 16,
            style: .continuous))
          .strokeStyle(cornerRadius: 16)
          .padding(.trailing)
        }
      }
    }
  }
}

struct RecentExpenseCardView_Previews: PreviewProvider {
  static var previews: some View {
    RecentExpenseCardView(expenseDate: "7/29", expenseTitle: "Balloons", expenseVendor: "BalloonDepot", expenseCost: 100.23, expenseCategory: "Supplies")
  }
}

