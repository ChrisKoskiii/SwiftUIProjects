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
      
      //Added duplicate to get shadow without applying to child views
      
      DuplicateView()
      
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
        .background(.ultraThinMaterial, in: RoundedRectangle(
          cornerRadius: 16,
          style: .continuous))
        .strokeStyle(cornerRadius: 16)
        .padding(.trailing)
      }
    }
  }
}

struct RecentExpenseCardView_Previews: PreviewProvider {
  static var previews: some View {
    RecentExpenseCardView(expenseDate: Date.now, expenseTitle: "Balloons", expenseVendor: "BalloonDepot", expenseCost: 100.23, expenseCategory: "Supplies")
  }
}

struct DuplicateView: View {
  var body: some View {
    ZStack {
      HStack(spacing: 0) {
        HStack(spacing: 0) {
          Text("")
            .fontWeight(.semibold)
            .padding(.leading)
          VStack(alignment: .leading, spacing: 0) {
            Text("")
              .lineLimit(1)
              .font(.headline)
              .padding(.leading)
              .padding(.top, 4)
            Text("")
              .font(.footnote)
              .padding(.leading)
            Text("")
              .font(.footnote)
              .padding(.leading)
              .padding(.bottom, 4)
          }
          Spacer()
          Text("")
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
    .shadow(color: .secondary, radius: 3, x: 2, y: 4)
  }
}
