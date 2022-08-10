//
//  View+Ext.swift
//  DubDubGrub
//
//  Created by Christopher Koski on 8/10/22.
//

import Foundation
import SwiftUI

extension View {
  func profileNameStyle() -> some View {
    self.modifier(ProfileNameText())
  }
}
