//
//  MonthlyTotalView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/30/22.
//

import SwiftUI

struct MonthlyTotalView: View {
  @ObservedObject var corevm: CoreDataViewModel
  @StateObject var homeVM = HomeViewModel()
  var body: some View {
    VStack {
      
      VStack(alignment: .leading, spacing: 0) {
        HStack {
          VStack(spacing: 16) {
            HStack(spacing: 0) {
              Text("This ")
                .font(.callout)
                .foregroundColor(.secondary)
              Menu {
                
                Button("week", action: {
                  if let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) {
                    corevm.getDateRangeExpenses(startDate: startDate, endDate: Date.now)
                  }
                  homeVM.setViewTotal(text: "week", expenses: corevm.dateRangeExpenses)
                  print(corevm.dateRangeExpenses)
                  print(homeVM.total)
                })
                
                Button("month", action: {
                  if let startDate = Calendar.current.date(byAdding: .month, value: -1, to: Date()) {
                    corevm.getDateRangeExpenses(startDate: startDate, endDate: Date.now)
                  }
                  homeVM.setViewTotal(text: "month", expenses: corevm.dateRangeExpenses)
                  print(corevm.dateRangeExpenses)
                  print(homeVM.total)
                })
                
                Button("year", action: {
                  if let startDate = Calendar.current.date(byAdding: .year, value: -1, to: Date()) {
                  corevm.getDateRangeExpenses(startDate: startDate, endDate: Date.now)
                }
                homeVM.setViewTotal(text: "year", expenses: corevm.dateRangeExpenses)
                  print(corevm.dateRangeExpenses)
                  print(homeVM.total)
              })
    
              } label: {
                ExtractedView(text: homeVM.selectedTimeFrame)
                Text(" so far:")
                  .font(.callout)
                  .foregroundColor(.secondary)
                Spacer()
              }
            }
            Text("$"+String(format: "%.2f", homeVM.total))
              .font(.largeTitle)
              .bold()
          }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.top, 4)
      }
      .padding(.horizontal)
    }
    .onAppear {
      homeVM.setViewTotal(text: "week", expenses: corevm.dateRangeExpenses)
    }
  }
  
}

struct MonthlyTotalView_Previews: PreviewProvider {
  static var previews: some View {
    MonthlyTotalView(corevm: CoreDataViewModel())
  }
}

struct ExtractedView: View {
  var text: String
  var body: some View {
    HStack(spacing: 0) {
      Text(text)
        .font(.callout)
        .bold()
      Image(systemName: "arrowtriangle.down.fill")
        .font(.caption)
    }
    .frame(width: 70)
    .foregroundColor(Color.brandPrimary)
    .overlay(Capsule()
      .stroke(Color.secondary, lineWidth: 1)
    )
  }
}
