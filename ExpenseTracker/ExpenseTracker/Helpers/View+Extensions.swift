//
//  View+Extensions.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/28/22.
//

import Foundation
import SwiftUI

//Buttons
struct ButtonStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.headline)
      .foregroundColor(.white)
      .frame(height: 55)
      .frame(maxWidth: .infinity)
      .background(Color("ButtonColor"))
      .cornerRadius(10)
      .padding(.horizontal)
  }
}

//Textfields
struct TextfieldStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.headline)
      .frame(height: 55)
      .padding(.leading)
      .background(Color("TextfieldColor"))
      .cornerRadius(10)
      .padding(.horizontal)
  }
}

struct StrokeStyle: ViewModifier {
  var cornerRadius: CGFloat
  @Environment(\.colorScheme) var colorScheme
  
  func body(content: Content) -> some View {
    content.overlay(
      RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        .stroke(
          .linearGradient(
            colors: [
              .white.opacity(colorScheme == .dark ? 0.6 : 0.3),
              .black.opacity(colorScheme == .dark ? 0.3 : 0.1)
            ], startPoint: .top, endPoint: .bottom
          )
        )
        .blendMode(.overlay)
    )
  }
}

extension View {
  func textfieldStyle() -> some View {
    modifier(TextfieldStyle())
  }
  func buttonStyle() -> some View {
    modifier(ButtonStyle())
  }
  func strokeStyle(cornerRadius: CGFloat = 30) -> some View {
    modifier(StrokeStyle(cornerRadius: cornerRadius))
  }
}


