//
//  EditFoodView.swift
//  CalorieCounter
//
//  Created by Christopher Koski on 5/11/22.
//

import SwiftUI

struct EditFoodView: View {
  @Environment (\.managedObjectContext) var managedObjectContext
  @Environment (\.dismiss) var dismiss
  
  var food: FetchedResults<Food>.Element
  
  @State private var title = ""
  @State private var calories: Double = 0
  @State private var protein: Double = 0
  
  var body: some View {
    ZStack {
      Form {
        Section {
          TextField("\(food.title!)", text: $title)
            .onAppear {
              title = food.title!
              calories = food.calories
              protein = food.protein
            }
          VStack {
            Text("Calories: \(Int(calories))")
            Slider(value: $calories, in: 0...1000, step: 10)
          }
          .padding()
          
          VStack {
            Text("Protein: \(Int(protein))")
            Slider(value: $protein, in: 0...1000, step: 10)
          }
          .padding()
          
          HStack {
            Spacer()
            Button("Submit") {
              DataController().editFood(food: food, title: title, calories: calories, protein: protein, context: managedObjectContext)
              dismiss()
            }
            Spacer()
          }
        }
      }
      PizzaHeadView()
        .offset(y: 200)
    }
  }
}

struct PizzaHeadView: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  @State private var isAnimated = false
  var body: some View {
    ZStack {
      Image("headOutline")
        .resizable()
        .scaledToFit()
        .opacity(0.8)
        .frame(width: 350, height: 350)
      Image("pizza")
        .resizable()
        .scaledToFit()
        .frame(width: 150, height: 150)
//        .opacity(0.8)
        .offset(x:-20, y: -60)
        .scaleEffect(isAnimated ? 0.9 : 1)
        .task {
          withAnimation(.easeInOut(duration: 0.8).repeatForever()) {
            isAnimated = true
          }
        }
    }
  }
}
