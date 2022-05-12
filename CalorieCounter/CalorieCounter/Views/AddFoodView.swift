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
      Form {
        Section {
          TextField("Food name", text: $title)
          
          VStack {
            Text("Calories: \(Int(calories))")
            Slider(value: $calories, in: 0...1000, step: 10)
          }
          .padding()
          
          VStack {
            Text("Protein: \(Int(protein))")
            Slider(value: $protein, in: 0...100, step: 1)
          }
          .padding()
          
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
    }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView()
    }
}
