//
//  RecentExpenseCardView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/28/22.
//

import SwiftUI
import CoreMotion

class MotionManager: ObservableObject {
  private let motionManager = CMMotionManager()
  @Published var x = 0.0
  @Published var y = 0.0
  
  init() {
    motionManager.startDeviceMotionUpdates(to: .main) { [weak self] data, error in
      
      guard let motion = data?.attitude else { return }
      self?.x = motion.roll
      self?.y = motion.pitch
    }
  }
  
}

struct RecentExpenseCardView: View {
  @StateObject private var motion = MotionManager()
  
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
          Text(expenseVendor)
            .foregroundColor(.secondary)
            .font(.footnote)
          Text(expenseCategory)
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
      .background(.ultraThickMaterial, in: RoundedRectangle(
        cornerRadius: 16,
        style: .continuous))
      .background(Color.white.cornerRadius(16).shadow(color: Color.secondary.opacity(0.2), radius: 50, x: 0, y: 0))
      .strokeStyle(cornerRadius: 16)
      .padding(.horizontal)
    }
  }
}

struct RecentExpenseCardView_Previews: PreviewProvider {
  static var previews: some View {
    RecentExpenseCardView(expenseDate: Date.now, expenseTitle: "Balloons", expenseVendor: "BalloonDepot", expenseCost: 100.23, expenseCategory: "Supplies")
  }
}
