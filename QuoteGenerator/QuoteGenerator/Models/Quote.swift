//
//  Quote.swift
//  QuoteGenerator
//
//  Created by Christopher Koski on 6/27/22.
//

import Foundation

struct Quote: Codable {
  var firstName: String = ""
  var lastName: String = ""
  var streetAddress: String = ""
  var city: String = ""
  var stories: Int = 1
  var sliders: Int = 0
  var windows: Int = 0
  var jobType: Int = 0
  var phoneNumber: String = ""
  var email: String = ""
  
  var isFilledOut: Bool {
    if firstName.isReallyEmpty || lastName.isReallyEmpty || streetAddress.isReallyEmpty || city.isReallyEmpty {
      return false
    } else {
      return true }
  }
  
  var getQuoteDisabled: Bool {
    if phoneNumber.isReallyEmpty || email.isReallyEmpty || !email.hasSuffix(".com") ||  !email.hasSuffix(".net") ||  !email.hasSuffix(".org"){
      return true
    } else {
      return false
    }
  }
  
}

