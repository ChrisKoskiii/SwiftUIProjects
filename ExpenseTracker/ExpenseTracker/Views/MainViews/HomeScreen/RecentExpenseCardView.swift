//
//  RecentExpenseCardView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/28/22.
//

import SwiftUI
import CoreMotion

struct RecentExpenseCardView: View {
  
  var recentExpense: ExpenseEntity
  
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
          Text(recentExpense.wrappedTitle)
            .foregroundColor(.black)
            .lineLimit(1)
            .font(.headline)
            .padding(.top, 4)
          Text(recentExpense.wrappedCategory)
            .foregroundColor(.secondary)
            .font(.footnote)
          Text(recentExpense.wrappedDate.formatDate())
            .foregroundColor(.secondary)
            .font(.footnote)
            .padding(.bottom, 4)
        }
        Spacer()
        let costString = formatter.string(from: NSNumber(value: recentExpense.cost))!
        Text(costString)
          .foregroundColor(.black)
          .font(.title2)
          .fontWeight(.semibold)
          .padding(.trailing)
      }
      .cardBackground()
      .padding(.horizontal)
    }
  }
}

//struct RecentExpenseCardView_Previews: PreviewProvider {
//  static var previews: some View {
//    RecentExpenseCardView(recentExpense: entity)
//  }
//}
