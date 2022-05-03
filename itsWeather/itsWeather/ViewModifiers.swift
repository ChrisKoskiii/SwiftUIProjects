//
//  ViewModifiers.swift
//  itsWeather
//
//  Created by Christopher Koski on 5/3/22.
//

import Foundation
import SwiftUI

//MARK: ThinMaterial Background
struct ThinMaterialBackground: ViewModifier {
  func body(content: Content) -> some View {
    content
      .background(.ultraThinMaterial, in:
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
      )
  }
}

extension View {
  func thinMaterialBackground() -> some View {
    modifier(ThinMaterialBackground())
  }
}

//MARK: Shadow

struct CustomShadow: ViewModifier {
  func body(content: Content) -> some View {
    content
      .shadow(color: Color("Shadow"), radius: 10, x: 0, y: 10)
  }
}

extension View {
  func customShadow() -> some View {
    modifier(CustomShadow())
  }
}
