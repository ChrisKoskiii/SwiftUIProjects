//
//  View+Extensions.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/28/22.
//

import Foundation
import SwiftUI

//Buttons
struct ScanButtonStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.headline)
      .foregroundColor(.white)
      .frame(height: 55)
      .frame(maxWidth: .infinity)
      .background(Color("ScanButtonColor"))
      .cornerRadius(10)
      .padding(.horizontal)
  }
}

struct AddButtonStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.headline)
      .foregroundColor(.white)
      .frame(height: 55)
      .frame(maxWidth: .infinity)
      .background(Color("AddButtonColor"))
      .cornerRadius(10)
      .padding(.horizontal)
  }
}

struct ToolBarButtonStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.footnote)
      .padding(.horizontal)
      .padding(.vertical, 4)
      .foregroundColor(.white)
      .background(.cyan)
      .clipShape(Capsule())
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

extension Image {
  public init(data: Data?, placeholder: String) {
    guard let data = data,
          let uiImage = UIImage(data: data) else {
      self = Image(systemName: "photo")
      return
    }
    self = Image(uiImage: uiImage)
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
  func scanButtonStyle() -> some View {
    modifier(ScanButtonStyle())
  }
  
  func addButtonStyle() -> some View {
    modifier(AddButtonStyle())
  }
  func strokeStyle(cornerRadius: CGFloat = 30) -> some View {
    modifier(StrokeStyle(cornerRadius: cornerRadius))
  }
  
  func toolBarButtonStyle() -> some View {
    modifier(ToolBarButtonStyle())
  }
}


