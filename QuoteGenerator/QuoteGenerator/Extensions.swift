//
//  Extensions.swift
//  QuoteGenerator
//
//  Created by Christopher Koski on 6/27/22.
//

import Foundation

extension String {
  var isReallyEmpty: Bool {
    let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
    return trimmed.isEmpty
  }
}
