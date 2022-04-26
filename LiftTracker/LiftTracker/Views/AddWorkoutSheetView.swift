//
//  AddWorkoutSheetView.swift
//  LiftTracker
//
//  Created by Christopher Koski on 2/3/22.
//

import SwiftUI

struct AddWorkoutSheetView: View {
  
  @Environment(\.presentationMode) var presentationMode
  
  @State private var workoutName = ""
  @State var exercises = [Exercise]()
  @State var showingAlert = false
  
  @Binding var workouts: [Workout]
  
  var body: some View {
    NavigationView {
      ZStack {
        VStack {
          Form {
            Section {
              TextField("Workout Name", text: $workoutName)
                .padding()
            }
            NavigationLink {
              AddExerciseView(exercises: $exercises)
            } label: {
              Text("Add Excercise")
            }
            .frame(width: 200, height: 50, alignment: .center)
            .foregroundColor(.blue)
            List {
              ForEach(exercises, id: \.self) { exercise in
                HStack {
                  Text("\(exercise.name)")
                  Spacer()
                  Text("\(exercise.sets) sets")
                  Spacer()
                  Text("\(exercise.reps) reps")
                }
              }
            }
          }
        }
        VStack {
          Spacer()
          Button {
            createWorkout()
          } label: {
            ZStack {
              Capsule()
                .foregroundColor(.secondary)
                .frame(width: 200, height: 60)
              Text("Create Workout")
                .font(.title)
                .foregroundColor(.white)
            }
          }
        }
      }
      .navigationBarHidden(true)
      .alert ("Add a name", isPresented: $showingAlert) {
        Button("OK") {}
      }
    }
  }
  
  func createWorkout() {
    let workout = Workout(id: UUID(), name: workoutName, exercises: exercises)
    if workoutName == "" {
      showingAlert = true
      return
    } else {
      workouts.append(workout)
      presentationMode.wrappedValue.dismiss()
    }
  }
  }

//struct AddWorkoutSheetView_Previews: PreviewProvider {
//
//  static var previews: some View {
//    AddWorkoutSheetView(workouts: workouts)
//  }
//}
