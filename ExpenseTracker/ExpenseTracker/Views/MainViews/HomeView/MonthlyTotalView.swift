//
//  MonthlyTotalView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/30/22.
//

import SwiftUI

struct MonthlyTotalView: View {
  @ObservedObject var corevm: CoreDataViewModel
  @State private var selectedTimeFrame = "month"
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
                Button("week", action: { selectedTimeFrame = "week" })
                Button("month", action: { selectedTimeFrame = "month" })
                Button("year", action: { selectedTimeFrame = "year" })
              } label: {
                ExtractedView(timeframe: selectedTimeFrame)
              }
              Text(" so far:")
                .font(.callout)
              .foregroundColor(.secondary)
              Spacer()
            }
            Text("$"+String(format: "%.2f", corevm.monthlyTotal))
              .font(.largeTitle)
              .bold()
          }
        }
      }
      .frame(maxWidth: .infinity)
      .padding(.horizontal)
      .padding(.top, 4)
    }
    //    .background(.ultraThickMaterial, in: RoundedRectangle(
    //      cornerRadius: 16,
    //      style: .continuous))
    //    .background(Color.white.cornerRadius(16).shadow(color: Color.secondary.opacity(0.2), radius: 50, x: 0, y: 0))
    //    .strokeStyle(cornerRadius: 16)
    .padding(.horizontal)
  }
}

struct MonthlyTotalView_Previews: PreviewProvider {
  static var previews: some View {
    MonthlyTotalView(corevm: CoreDataViewModel())
  }
}

struct ExtractedView: View {
  var timeframe: String
  var body: some View {
    HStack(spacing: 0) {
      Text(timeframe)
        .font(.callout)
        .bold()
      Image(systemName: "arrowtriangle.down.fill")
        .font(.caption)
    }
    .frame(width: 70)
    .foregroundColor(Color.brandPrimary)
    .padding(.horizontal, 4)
    .overlay(Capsule()
      .stroke(Color.secondary, lineWidth: 1)
    )
  }
}
