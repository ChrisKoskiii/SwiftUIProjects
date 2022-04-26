//
//  Exercise.swift
//  LiftTracker
//
//  Created by Christopher Koski on 2/4/22.
//

import Foundation

struct Exercise: Identifiable, Hashable {
  var id = UUID()
  var name: String
  var reps: Int
  var sets: Int
  
  init(name: String, reps: Int, sets: Int) {
    self.name = name
    self.reps = reps
    self.sets = sets
  }
}
