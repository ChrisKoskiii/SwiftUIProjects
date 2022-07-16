//
//  Dashboard.swift
//  MyExpense
//
//  Created by Christopher Koski on 7/14/22.
//

import SwiftUI

struct DashboardView: View {
  @State var showingAddExpenseSheet = false
  
  @FetchRequest(sortDescriptors: []) var expenseItems: FetchedResults<Expense>
  
  var body: some View {
    NavigationView {
      ZStack {
        GreetingText()
        VStack {
          SummaryCardView()
        }
      }
      .toolbar {
        ToolbarItem {
          Button {
            showingAddExpenseSheet.toggle()
          } label: {
            Image(systemName: "plus")
              .font(.title2)
              .foregroundColor(.white)
          }
        }
      }
      .sheet(isPresented: $showingAddExpenseSheet, content: {
        AddItemSheet()
      })
      .navigationTitle("MyExpense")
      .navigationBarTitleDisplayMode(.inline)
      .background(
        ZStack {
          Color.backgroundColor
          SpinningShape()
            .offset(x: 0, y: -380)
        }
      )
    }
  }
}


struct GreetingText: View {
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text("Goodmorning")
          .font(.title)
          .fontWeight(.bold)
          .foregroundStyle(.linearGradient(colors: [.primary, .primary.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
        Spacer()
      }
      Spacer()
    }
    .padding(.leading, 8)
    .padding(.top, 8)
  }
}

struct SummaryCardView: View {
  var body: some View {
    VStack {
      Spacer()
      MonthlyTotal()
      RecentExpenses()
      Spacer()
      Spacer()
    }
  }
}

struct SpinningShape: View {
  @State var appear = false
  
  var body: some View {
    ZStack {
      Image(systemName: "seal.fill")
        .resizable()
        .foregroundColor(.cyan)
        .scaledToFit()
        .frame(width: 500, height: 500)
        .rotationEffect(.degrees(appear ? 360 : 0))
        .onAppear {
          withAnimation(.linear(duration: 100).repeatForever(autoreverses: true)) {
            appear = true
          }
        }
    }
  }
}

struct RecentExpenses: View {
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text("Recent expenses:")
          .font(.caption)
          .padding(.top, 8)
          .padding(.leading, 16)
          .padding(.bottom)
        Spacer()
      }
      ForEach(1..<6) { _ in
        HStack {
          VStack(alignment: .leading) {
            Text("$34.50")
              .font(.body)
            Text("Supplies")
              .font(.footnote)
          }
          .padding(.leading)
          .padding(.bottom, 4)
          Spacer()
          VStack(alignment: .trailing) {
            Text("Wal-Mart")
              .font(.body)
            Text("4/13")
              .font(.footnote)
          }
          .padding(.trailing)
          .padding(.bottom, 4)
        }
      }
      Spacer()
    }
    .frame(maxWidth: .infinity)
    .frame(maxHeight: 300)
    .background(.ultraThinMaterial, in:
                  RoundedRectangle(cornerRadius: 20)
    )
    .padding(.horizontal, 16)
  }
}

struct MonthlyTotal: View {
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 0) {
        Text("Total spent this month:")
          .font(.caption)
          .padding(.leading, 16)
        HStack {
          Text("$1,234")
            .font(.title)
            .fontWeight(.bold)
            .padding(.bottom, 16)
            .padding(.leading, 16)
          Spacer()
          Spacer()
        }
      }
      Spacer()
      VStack {
        Button {
          //show summary?
        } label: {
          Image(systemName: "ellipsis.circle")
        }
        .padding()
        Spacer()
      }
    }
    .frame(maxWidth: .infinity)
    .frame(maxHeight: 100)
    .background(.ultraThinMaterial, in:
                  RoundedRectangle(cornerRadius: 20)
    )
    .padding(.horizontal, 16)
    .padding(.bottom, 16)
  }
}

struct DashboardView_Previews: PreviewProvider {
  static var previews: some View {
    DashboardView()
  }
}
