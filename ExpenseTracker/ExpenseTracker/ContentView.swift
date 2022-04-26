//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 4/24/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      NavigationView {
        ScrollView {
          VStack(alignment: .leading, spacing: 24) {
            Text("Overview")
              .font(.title2)
              .bold()
            RecentTransactionList()
          }
          .padding()
          .frame(maxWidth: .infinity)
        }
        .background(Color.background)
        .navigationBarTitleDisplayMode(.inline)
      }
      .navigationViewStyle(.stack)
      .toolbar {
        // MARK: Notification Icon
        Image(systemName: "bell.badge")
          .symbolRenderingMode(.palette)
          .foregroundStyle(Color.icon, .primary)
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()

    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(transactionListVM)
    }
}
