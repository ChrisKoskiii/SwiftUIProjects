//
//  RecentExpenseCardView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/28/22.
//

import SwiftUI

struct RecentExpenseCardView: View {
  var expenseDate: Date
  var expenseTitle: String
  var expenseVendor: String
  var expenseCost: Double
  var expenseCategory: String
  
  var formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.maximumFractionDigits = 2
    return formatter
  }()
  
  var body: some View {
    ZStack {
      HStack(spacing: 0) {
        HStack(spacing: 0) {
          Text(expenseDate.formatDate())
            .fontWeight(.semibold)
            .padding(.leading)
          VStack(alignment: .leading, spacing: 0) {
            Text(expenseTitle)
              .lineLimit(1)
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
          let costString = formatter.string(from: NSNumber(value: expenseCost))!
          Text(costString)
            .font(.title2)
            .fontWeight(.bold)
            .padding(.trailing)
        }
        .background(.ultraThickMaterial, in: RoundedRectangle(
          cornerRadius: 16,
          style: .continuous))
        .background(Color.white.cornerRadius(16).shadow(color: Color.secondary.opacity(0.2), radius: 50, x: 0, y: 0))
        .strokeStyle(cornerRadius: 16)
        .padding(.horizontal)
      }
    }
  }
}

struct RecentExpenseCardView_Previews: PreviewProvider {
  static var previews: some View {
    RecentExpenseCardView(expenseDate: Date.now, expenseTitle: "Balloons", expenseVendor: "BalloonDepot", expenseCost: 100.23, expenseCategory: "Supplies")
  }
}
