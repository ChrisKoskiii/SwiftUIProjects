//
//  WorkoutStartView.swift
//  LiftTracker
//
//  Created by Christopher Koski on 2/7/22.
//

import SwiftUI

struct WorkoutStartView: View {
  
  let workout: Workout
  
  var body: some View {
    NavigationView {
      ZStack {
        List {
          ForEach(workout.exercises) { exercise in
            HStack {
              Text("\(exercise.name)")
              Spacer()
              Text("\(exercise.sets) sets")
              Spacer()
              Text("\(exercise.reps) reps")
            }
          }
        }
        VStack {
          Spacer()
          Spacer()
          Button {
            //start workout
          } label: {
            ZStack {
              Capsule()
                .foregroundColor(.secondary)
                .frame(width: 200, height: 60)
              Text("Start Workout")
                .font(.title)
                .foregroundColor(.white)
            }
          }
        }
        .navigationTitle(Text("\(workout.name)"))
        .navigationBarTitleDisplayMode(.inline)
      }
    }
  }
}

struct WorkoutStartView_Previews: PreviewProvider {
  static var previews: some View {
    var id = UUID()
    var workout = Workout(id: id, name: "Day 3", exercises: [Exercise]())
    WorkoutStartView(workout: workout)
  }
}
