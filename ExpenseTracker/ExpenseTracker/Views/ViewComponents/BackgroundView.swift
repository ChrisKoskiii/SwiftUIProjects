//
//  BackgroundView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/28/22.
//

import SwiftUI

import SwiftUI

struct BackgroundView: View {
  @AppStorage("selectedTab") var selectedTab: Tab = .home
  @State var animateGradient = false
  
  var gradientColor: Color {
    switch selectedTab {
    case .home:
        return .cyan
    case .expenses:
        return .blue
    case .reports:
        return .red
    case .settings:
        return .pink
    }
  }

  var body: some View {
    LinearGradient(colors: [gradientColor.opacity(0.2), .white, .white], startPoint: .bottomLeading, endPoint: .topTrailing)
        .blur(radius: 30)
        .ignoresSafeArea()
  }
}


struct BackgroundView_Previews: PreviewProvider {
  static var previews: some View {
    BackgroundView()
    BackgroundView()
      .preferredColorScheme(.dark)
  }
}
