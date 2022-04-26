//
//  ExercisesModel.swift
//  LiftTracker
//
//  Created by Christopher Koski on 2/4/22.
//

import Foundation

class ExercisesModel: ObservableObject {
  @Published var exercises = [Exercise]()
}
