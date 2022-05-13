//
//  TaSK.swift
//  myTask
//
//  Created by Christopher Koski on 5/12/22.
//

import SwiftUI

struct Task {
  var id = UUID().uuidString
  var title: String
  var time: Date = Date()
}

//total task meta view
struct TaskMetaData: Identifiable {
  var id = UUID().uuidString
  var task: [Task]
  var taskDate: Date
}

//sampel date for testing
func getSampleDate(offset: Int) -> Date {
  let calander = Calendar.current
  
  let date = calander.date(byAdding: .day, value: offset, to: Date())
  
  return date ?? Date()
}

var tasks: [TaskMetaData] = [
  TaskMetaData(task: [
    Task(title: "Talk to iJustine"),
    Task(title: "iPhone 14 Great Design Change"),
    Task(title: "Nothing Much Workout")
  ], taskDate: getSampleDate(offset: 1))
]
