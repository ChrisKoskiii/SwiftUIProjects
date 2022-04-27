//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Christopher Koski on 4/26/22.
//

import SwiftUI

struct ContentView: View {
  var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
  var correctAnswer = Int.random(in: 0...2)
  
  var body: some View {
    ZStack {
      Color.blue
        .ignoresSafeArea()
      VStack {
        VStack(spacing: 30) {
          Text("Tap the flag of")
            .foregroundColor(.white)
          Text(countries[correctAnswer])
            .foregroundColor(.white)
        }
        ForEach(0..<3) { number in
          Button {
            //action
          } label: {
            Image(countries[number])
              .renderingMode(.original)
          }
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
