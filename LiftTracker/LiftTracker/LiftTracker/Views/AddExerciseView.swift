//
//  AddExerciseView.swift
//  LiftTracker
//
//  Created by Christopher Koski on 2/3/22.
//

import SwiftUI

struct AddExerciseView: View {
  
  @Environment(\.presentationMode) var presentationMode
  
  @Binding var exercises: [Exercise]
  
  @State var exerciseName = ""
  @State var reps = 0
  @State var sets = 0
  
  var body: some View {
    VStack {
      Form {
        Section {
        TextField("Exercise Name", text: $exerciseName)
          .padding()
        }
        Section {
          TextField("Amount of Reps", value: $reps, formatter: NumberFormatter())
          .pickerStyle(.automatic)
        } header: {
          Text("Reps")
        }
        Section {
          TextField("Amount of Sets", value: $sets, formatter: NumberFormatter())
          .pickerStyle(.automatic)
        } header: {
          Text("Sets")
        }
        Button {
          submitExercise()
        } label: {
          Text("Submit")
        }
      }
    }
  }
  func submitExercise() {
    var exercise = Exercise(name: exerciseName, reps: reps, sets: sets)
    exercise.name = exerciseName
    exercises.append(exercise)
    presentationMode.wrappedValue.dismiss()
  }
}

//  struct AddExerciseView_Previews: PreviewProvider {
//
//    static var previews: some View {
//      AddExerciseView(exercises:)
//    }
//  }
