//
//  Date+Extension.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/29/22.
//

import Foundation

extension Date {
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MM/dd")
        return dateFormatter.string(from: self)
    }
}
