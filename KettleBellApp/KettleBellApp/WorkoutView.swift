//
//  WorkoutView.swift
//  KettleBellApp
//
//  Created by Christopher Koski on 1/24/22.
//

import SwiftUI

struct WorkoutView: View {
  
  @State var reps: Int
  
  var body: some View {
    NavigationView {
      VStack {
        Section {
          List {
            ForEach(0..<10, id: \.self) { exerciseSet in
              HStack(spacing: 10) {
                Text("Set 1")
                Spacer()
                Picker("Number of Reps", selection: $reps) {
                  ForEach(0..<20) {
                    Text("\($0)")
                  }
                }
                .pickerStyle(.menu)
              }
            }
          }
        }
      }
      .navigationTitle("Workout A")
    }
  }
}

struct WorkoutView_Previews: PreviewProvider {
  static var previews: some View {
    WorkoutView(reps: 10)
  }
}
