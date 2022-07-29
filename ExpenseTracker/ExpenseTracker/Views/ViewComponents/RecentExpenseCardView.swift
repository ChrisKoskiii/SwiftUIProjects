//
//  RecentExpenseCardView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/28/22.
//

import SwiftUI

struct RecentExpenseCardView: View {
  var expenseTitle: String
  var expenseVendor: String
  var expenseCost: Double
  
  var body: some View {
    ZStack {
      HStack(spacing: 0) {
        ZStack {
          Image(systemName: "scissors")
            .font(.largeTitle)
            .padding(12)
            .foregroundColor(.white)
            .background(Circle().fill(.ultraThinMaterial))
            .shadow(radius: 5)
        }
        Group {
          HStack {
            VStack(alignment: .leading) {
              Text(expenseTitle)
                .font(.title3)
                .fontWeight(.semibold)
              
                .padding(.leading)
                .padding(.top, 4)
              Text(expenseVendor)
                .padding(.leading)
              
              Text("Thursday")
                .font(.footnote)
                .kerning(3)
                .padding(.leading)
                .padding(.bottom, 4)
            }
            Spacer()
            HStack {
              Text("$")
                .font(.title2)
                .fontWeight(.bold)
              Text(String(expenseCost))
                .font(.title2)
                .fontWeight(.bold)
                .padding(.trailing)
            }
          }
          .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
          .padding(.trailing)
        }
        .shadow(radius: 5)
      }
    }
  }
}

struct RecentExpenseCardView_Previews: PreviewProvider {
  static var previews: some View {
    RecentExpenseCardView(expenseTitle: "Balloons", expenseVendor: "BalloonDepot", expenseCost: 100.23)
  }
}

