//
//  AddFoodView.swift
//  CalorieCounter
//
//  Created by Christopher Koski on 5/11/22.
//

import SwiftUI

struct AddFoodView: View {
  @Environment (\.managedObjectContext) var managedObjectContext
  @Environment (\.dismiss) var dismiss
  
  @State private var title = ""
  @State private var calories: Double = 0
  @State private var protein: Double = 0
  
    var body: some View {
      ZStack {
        Form {
          Section {
            TextField("Food name", text: $title)
            calorieSlider
            proteinSlider
            submitButton
          }
        }
        TacoView()
          .offset(x: 0, y: 150)
      }
      .ignoresSafeArea(.keyboard)
    }
  
  var calorieSlider: some View {
    VStack {
      Text("Calories: \(Int(calories))")
      Slider(value: $calories, in: 0...1000, step: 10)
    }
    .padding()
  }
  
  var proteinSlider: some View {
    VStack {
      Text("Protein: \(Int(protein))")
      Slider(value: $protein, in: 0...100, step: 1)
    }
    .padding()
  }
  
  var submitButton: some View {
    HStack {
      Spacer()
      Button("Submit") {
        DataController().addFood(title: title, calories: calories, protein: protein, context: managedObjectContext)
          dismiss()
      }
      Spacer()
    }
  }
}

struct TacoView: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  @State private var isAnimated = false
  var body: some View {
    Image("happyTaco")
      .resizable()
      .scaledToFit()
      .frame(width: 300, height: 400)
      .opacity(colorScheme == .dark ? 0.7 : 0.5)
      .rotationEffect(.degrees(isAnimated ? 10 : -10))
      .onAppear {
        withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
          isAnimated = true
        }
      }
  }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView()
    }
}


