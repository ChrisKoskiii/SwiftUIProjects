//
//  TimeFormat.swift
//  CalorieCounter
//
//  Created by Christopher Koski on 5/11/22.
//

import Foundation

func calcTimeSince(date: Date) -> String {
  
  let minutes = Int(-date.timeIntervalSinceNow)/60
  let hours = minutes/60
  let days = hours/24
  
  //Our "X time ago" label calculations
  if minutes < 120 {
    return "\(minutes) minutes ago"
  } else if minutes >= 120 && hours < 48 {
    return "\(hours) hours ago"
  } else {
    return "\(days) days ago"
  }
}
