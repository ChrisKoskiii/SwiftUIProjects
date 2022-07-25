//
//  BackgroundView.swift
//  MyList
//
//  Created by Christopher Koski on 2/5/22.
//

import SwiftUI

struct BackgroundView: View {
  @State var animateGradient = true
  
  var body: some View {
    LinearGradient(colors: [.blue.opacity(0.5), .pink.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)
      .hueRotation(.degrees(animateGradient ? 45 : 0))
      .ignoresSafeArea()
      .onAppear {
        withAnimation(.easeInOut(duration: 4.0).repeatForever(autoreverses: true)) {
          animateGradient.toggle()
        }
      }
  }
}

struct BackgroundView_Previews: PreviewProvider {
  static var previews: some View {
    BackgroundView()
  }
}
