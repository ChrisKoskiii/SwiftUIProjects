//
//  Extensions.swift
//  itsWeather
//
//  Created by Christopher Koski on 5/2/22.
//

import SwiftUI

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
      
    }
}

extension View {
  func animate(using animation: Animation = .easeInOut(duration: 0.6), _ action: @escaping () -> Void) -> some View {
        onAppear {
            withAnimation(animation) {
                action()
            }
        }
    }
}

