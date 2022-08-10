//
//  CustomModifiers.swift
//  DubDubGrub
//
//  Created by Christopher Koski on 8/10/22.
//

import Foundation
import SwiftUI

struct ProfileNameText: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.system(size: 32, weight: .bold))
      .lineLimit(1)
      .minimumScaleFactor(0.75)
  }
}

