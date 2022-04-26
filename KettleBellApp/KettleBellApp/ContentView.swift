//
//  ContentView.swift
//  KettleBellApp
//
//  Created by Christopher Koski on 1/24/22.
//

import SwiftUI

struct ContentView: View {
  
  var workoutsArray = ["Leg Day", "Chest Day", "Upper", "Lower"]
  
    var body: some View {
      NavigationView {
        List(workoutsArray, id: \.self) { workout in
          NavigationLink {
            WorkoutView(reps: 10)
            } label: {
              Text(workout)
            }
        }
        .navigationTitle("Workouts")
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
