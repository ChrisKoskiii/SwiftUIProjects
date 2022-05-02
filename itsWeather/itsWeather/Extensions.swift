//
//  Extensions.swift
//  itsWeather
//
//  Created by Christopher Koski on 5/2/22.
//

import Foundation

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
      
    }
}

