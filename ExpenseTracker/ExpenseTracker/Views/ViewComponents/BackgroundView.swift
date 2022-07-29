//
//  BackgroundView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/28/22.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
      ZStack {
        LinearGradient(gradient: Gradient(colors: [.pink.opacity(0.1), .white, .white]), startPoint: .bottomLeading, endPoint: .topTrailing)
//        RadialGradient(gradient: Gradient(colors: [.pink.opacity(0.1), .white]), center: .center, startRadius: 50, endRadius: 300)
//          .frame(width: 200, height: 200)
      }
      .overlay(.ultraThinMaterial)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
