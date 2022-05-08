//
//  PreferenceKeys.swift
//  DesignCodeiOS15
//
//  Created by Christopher Koski on 5/4/22.
//

import SwiftUI

struct ScrollPreferenceKey: PreferenceKey {
  static var defaultValue: CGFloat = 0
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = nextValue()
  }
}
