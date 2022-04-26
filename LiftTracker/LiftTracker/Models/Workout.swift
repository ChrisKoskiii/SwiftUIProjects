//
//  Workout.swift
//  LiftTracker
//
//  Created by Christopher Koski on 2/3/22.
//

import Foundation

struct Workout: Identifiable {
  
  var id: UUID
  var name: String
  var exercises: [Exercise]
  
}
