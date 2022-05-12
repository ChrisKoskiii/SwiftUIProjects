//
//  ContentView.swift
//  CalorieCounter
//
//  Created by Christopher Koski on 5/11/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) var managedObjectContext
  @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
  
  var body: some View {
    NavigationView {
      MainView()
    }
    .navigationViewStyle(.stack)
  }
}

struct MainView: View {
  @State private var showingAddView = false
  
  var body: some View {
    VStack(alignment: .leading) {
      CalorieCountView()
      FoodListView()
    }
    .navigationTitle("CalorieCounter")
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          showingAddView.toggle()
        } label: {
          Label("Add Food", systemImage: "plus.circle")
        }
      }
      ToolbarItem(placement: .navigationBarLeading) {
        EditButton()
      }
    }
    .sheet(isPresented: $showingAddView) {
      AddFoodView()
    }
  }
}

//Calorie count for the day text label
struct CalorieCountView: View {
  @Environment(\.managedObjectContext) var managedObjectContext
  @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
  
  var body: some View {
    VStack(alignment: .leading) {
    Text("\(Int(totalCaloriesToday())) Kcal (Today)")
      .foregroundColor(.gray)
      .padding(.horizontal)
    Text("\(Int(totalProteinToday()))g of Protein (Today)")
        .foregroundColor(.gray)
        .padding(.horizontal)
    }
  }
  
  private func totalCaloriesToday() -> Double {
    var caloriesToday: Double = 0
    for item in food {
      if Calendar.current.isDateInToday(item.date!) {
        caloriesToday += item.calories
      }
    }
    return caloriesToday
  }
  
  private func totalProteinToday() -> Double {
    var proteinToday: Double = 0
    for item in food {
      if Calendar.current.isDateInToday(item.date!) {
        proteinToday += item.protein
      }
    }
    
    return proteinToday
  }
}

//List of food items entered
struct FoodListView: View {
  @Environment(\.managedObjectContext) var managedObjectContext
  @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
  
  var body: some View {
    List {
      ForEach(food) { food in
        NavigationLink(destination: EditFoodView(food: food)) {
          HStack {
            VStack(alignment: .leading, spacing: 6) {
              Text(food.title!)
                .bold()
              
              Text("\(Int(food.calories))") + Text(" calories").foregroundColor(.red)
              Text("\(Int(food.protein))") + Text(" protein")
            }
            Spacer()
            Text(calcTimeSince(date: food.date!))
              .foregroundColor(.gray)
              .italic()
          }
        }
      }
      .onDelete(perform: deleteFood)
    }
    .listStyle(.plain)
  }
  
  private func deleteFood(offsets: IndexSet) {
    withAnimation {
      offsets.map { food[$0] }.forEach(managedObjectContext.delete)
      
      DataController().save(context: managedObjectContext)
    }
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}


