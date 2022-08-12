//
//  RecentExpenseCardView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/28/22.
//

import SwiftUI
import CoreMotion

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
      HStack(spacing: 16) {
        Image(systemName: "house.fill")
          .resizable()
          .scaledToFit()
          .foregroundColor(Color.brandPrimary)
          .frame(width: 30, height: 30)
          .padding(.leading)
        Divider()
          .frame(height: 40)
        VStack(alignment: .leading, spacing: 0) {
          Text(expenseTitle)
            .lineLimit(1)
            .font(.headline)
            .padding(.top, 4)
          Text(expenseCategory)
            .foregroundColor(.secondary)
            .font(.footnote)
          Text(expenseDate.formatDate())
            .foregroundColor(.secondary)
            .font(.footnote)
            .padding(.bottom, 4)
        }
        Spacer()
        let costString = formatter.string(from: NSNumber(value: expenseCost))!
        Text(costString)
          .font(.title2)
          .fontWeight(.semibold)
          .padding(.trailing)
      }
      .cardBackground()
      .padding(.horizontal)
    }
  }
}

struct RecentExpenseCardView_Previews: PreviewProvider {
  static var previews: some View {
    RecentExpenseCardView(expenseDate: Date.now, expenseTitle: "Balloons", expenseVendor: "BalloonDepot", expenseCost: 100.23, expenseCategory: "Supplies")
  }
}
