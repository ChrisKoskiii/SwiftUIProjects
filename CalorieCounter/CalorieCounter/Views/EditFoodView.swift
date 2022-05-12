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
  
  var body: some View {
    Form {
      Section {
        TextField("\(food.title!)", text: $title)
          .onAppear {
            title = food.title!
            calories = food.calories
          }
        VStack {
          Text("Calories: \(Int(calories))")
          Slider(value: $calories, in: 0...1000, step: 10)
        }
        .padding()
        
        HStack {
          Spacer()
          Button("Submit") {
            DataController().editFood(food: food, title: title, calories: calories, context: managedObjectContext)
            dismiss()
          }
          Spacer()
        }
      }
    }
    }
}

