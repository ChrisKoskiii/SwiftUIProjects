//
//  MonthlyTotalView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/30/22.
//

import SwiftUI

struct MonthlyTotalView: View {
  @ObservedObject var corevm: CoreDataViewModel
  
  var body: some View {
    VStack {
      
      VStack(spacing: 0) {
        
        HStack {
          Spacer()
          Text("This month so far:")
            .font(.caption)
            .foregroundColor(.secondary)
          Spacer()
        }
        
        HStack {
          Spacer()
          Text("$"+String(format: "%.2f", corevm.monthlyTotal))
            .font(.largeTitle)
          Spacer()
        }
        
      }
      .padding(.horizontal)
      .padding(.top, 4)
    }
    .background(.ultraThickMaterial, in: RoundedRectangle(
      cornerRadius: 16,
      style: .continuous))
    .background(Color.white.cornerRadius(16).shadow(color: Color.secondary.opacity(0.2), radius: 50, x: 0, y: 0))
    .strokeStyle(cornerRadius: 16)
    .padding(.horizontal)
  }
}

struct MonthlyTotalView_Previews: PreviewProvider {
  static var previews: some View {
    MonthlyTotalView(corevm: CoreDataViewModel())
  }
}
