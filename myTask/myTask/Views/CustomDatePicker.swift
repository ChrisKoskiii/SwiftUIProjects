//
//  CustomDatePicker.swift
//  myTask
//
//  Created by Christopher Koski on 5/12/22.
//

import SwiftUI

struct CustomDatePicker: View {
  
  @Binding var currentDate: Date
  
  //Update month with arrow taps
  @State var currentMonth: Int = 0
  
  var body: some View {
    VStack(spacing: 35) {
      // Days..
      let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
      
      HStack(spacing: 20) {
        VStack(alignment: .leading, spacing: 10) {
          Text(extraDate()[0])
            .font(.caption)
            .fontWeight(.semibold)
          
          Text(extraDate()[1])
            .font(.title.bold())
        }
        
        Spacer(minLength: 0)
        
        Button {
          withAnimation {
            currentMonth -= 1
          }
        } label: {
          Image(systemName: "chevron.left")
            .font(.title2)
        }
        Button {
          withAnimation {
            currentMonth -= 1
          }
        } label: {
          Image(systemName: "chevron.right")
            .font(.title2)
        }
      }
      .padding(.horizontal)
      //Day View
      HStack(spacing: 0) {
        ForEach(days, id: \.self) { day in
          Text(day)
            .font(.callout)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
        }
      }
      
      let columns = Array(repeating: GridItem(.flexible()), count: 7)
      
      LazyVGrid(columns: columns, spacing: 15) {
        ForEach(extractDate()) { value in
          CardView(value: value)
            .background(
              Capsule()
                .fill(Color("Pink"))
                .padding(.horizontal, 8)
                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
            )
            .onTapGesture {
              currentDate = value.date
            }
        }
      }
    }
    .onChange(of: currentMonth) { newValue in
      
      currentDate = getCurrentMonth()
      
    }
  }
  
  @ViewBuilder
  func CardView(value: DateValue) -> some View {
    VStack {
      if value.day != -1 {
        if let task = tasks.first(where: { task in
          
          return isSameDay(date1: task.taskDate, date2: value.date)
        }){
          Text("\(value.day)")
            .font(.title3.bold())
            .foregroundColor(isSameDay(date1: task.taskDate, date2: currentDate) ? .white : .primary)
          Spacer()
          
          Circle()
            .fill(isSameDay(date1: task.taskDate, date2: currentDate) ? .white : Color("Pink"))
            .frame(width: 8, height: 8)
        }
        else {
          Text("\(value.day)")
            .font(.title3.bold())
            .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
          Spacer()
        }
      }
    }
    .padding(.vertical, 9)
    .frame(height: 60, alignment: .top)
  }
  
  //checking dates
  func isSameDay(date1: Date, date2: Date) -> Bool {
    let calendar = Calendar.current
    
    return calendar.isDate(date1, inSameDayAs: date2)
  }
  
  func extraDate() -> [String] {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY MMMM"
    
    let date = formatter.string(from: currentDate)
    
    return date.components(separatedBy: " ")
  }
  
  func getCurrentMonth() -> Date {
    let calendar = Calendar.current
    //Getting current month date
    guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
      return Date()
    }
    
    return currentMonth
  }
  
  func extractDate() -> [DateValue] {
    
    let calendar = Calendar.current
    //Getting current month date
    let currentMonth = getCurrentMonth()
    
    var days = currentMonth.getAllDates().compactMap { date -> DateValue in
      //getting day
      
      let day = calendar.component(.day, from: date)
      
      return DateValue(day: day, date: date)
    }
    
    //add offset days
    let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
    
    for _ in 0..<firstWeekday - 1 {
      days.insert(DateValue(day: -1, date: Date()), at: 0)
    }
    
    return days
  }
}

struct CustomDatePicker_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

//Extending Date to get current Month Dates
extension Date {
  func getAllDates() -> [Date] {
    let calendar = Calendar.current
    
    //get start date
    let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
    
    let range = calendar.range(of: .day, in: .month, for: startDate)!
    
    return range.compactMap { day -> Date in
      
      return calendar.date(byAdding: .day, value: day - 1, to: self)!
    }
  }
}
