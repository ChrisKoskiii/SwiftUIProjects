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
      ZStack {
        BackgroundView()
          .offset(x: 10, y: 200)
        MainView()
      }
      .ignoresSafeArea()
    }
    .navigationViewStyle(.stack)
  }
}

struct MainView: View {
  @State var showingAddView = false
  var body: some View {
    VStack {
      ZStack {
        VStack(alignment: .leading) {
          NavigationBarView(showingAddView: $showingAddView)
          FoodListView()
        }
      }
      .navigationBarHidden(true)
      .sheet(isPresented: $showingAddView) {
        AddFoodView()
      }
    }
    .padding(.top, 40)
  }
}

struct NavigationBarView: View {
  @Binding var showingAddView: Bool
  var body: some View {
    ZStack {
      VStack(alignment: .leading) {
        Text("CalorieCounter")
          .font(.largeTitle.weight(.bold))
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.leading, 12)
          .padding(.top, 20)
        CalorieCountView()
      }
      VStack {
        Button {
          showingAddView.toggle()
        } label: {
          Image(systemName: "plus")
            .font(.title3.weight(.bold))
            .frame(width: 36, height: 36)
            .foregroundColor(.secondary)
            .background(.ultraThinMaterial, in:
                          RoundedRectangle(cornerRadius: 14, style: .continuous)
            )
            .strokeStyle(cornerRadius: 14)
        }
      }
      .frame(maxWidth: .infinity, alignment: .trailing)
      .padding(.trailing, 20)
      .padding(.top, 20)
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
      .listRowBackground(Color.clear)
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


struct BackgroundView: View {

  var body: some View {
    Image("foodMeasure")
      .resizable()
      .scaledToFit()
      .frame(width: 400, height: 400)
      .opacity(0.2)
  }
}
