//
//  DateConversion.swift
//  Weatha
//
//  Created by Christopher Koski on 3/30/22.
//

import Foundation

struct DateConversion {
  
  func convertDate(from dt: Int) -> String {
    let doubleDt = Double(dt)
    let date = NSDate(timeIntervalSince1970: doubleDt)
    
    let formatter = DateFormatter()
    // initially set the format based on your datepicker date / server String
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    let myString = formatter.string(from: date as Date)
    // convert your string to date
    let yourDate = formatter.date(from: myString)
    //then again set the date format whhich type of output you need
    formatter.dateFormat = "yyyy-MM-dd"
    // again convert your date to string
    let myStringDate = formatter.string(from: yourDate!)
    
    let dayOfWeekInt = getDayOfWeek(myStringDate) ?? 1
    
    let dayOfWeekString = dayInttoDayString(with: dayOfWeekInt)
    
    return dayOfWeekString
  }

  func getDayOfWeek(_ today:String) -> Int? {
    let formatter  = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    guard let todayDate = formatter.date(from: today) else { return nil }
    let myCalendar = Calendar(identifier: .gregorian)
    let weekDay = myCalendar.component(.weekday, from: todayDate)
    return weekDay
  }
  
  func dayInttoDayString(with day: Int) -> String {
    switch day {
    case 1:
      return "Sunday"
    case 2:
      return "Monday"
    case 3:
      return "Tuesday"
    case 4:
      return "Wednesday"
    case 5:
      return "Thursday"
    case 6:
      return "Friday"
    case 7:
      return "Saturday"
    default:
      return "Day Of Week"
    }
  }

}
