//
//  ReportsView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/29/22.
//

import SwiftUI

struct ReportsView: View {
  @EnvironmentObject var coreVM: CoreDataViewModel
  @ObservedObject var corevm: CoreDataViewModel
  
  @State private var opacity = 0.0
  
  @State var PDFUrl: Data?
  @State var showShareSheet: Bool = false
  
  @State var expense: ExpenseEntity?
  
  @State var startDate: Date
  @State var endDate: Date
  
  var formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.maximumFractionDigits = 2
    return formatter
  }()
  
  var body: some View {
    expenseList
      .navigationBarTitle("Generate Reports")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem {
          Button {
            showShareSheet.toggle()
          } label : {
            Image(systemName: "square.and.arrow.up.fill")
          }
        }
      }
      .sheet(isPresented: $showShareSheet) {
        PDFUrl = nil
      } content: {
        if let PDFUrl = PDFUrl {
          ShareSheet(urls: [PDFUrl])
        }
      }
      .onAppear {
        corevm.getDateRangeExpenses(startDate: startDate, endDate: endDate)
        DispatchQueue.main.async {
          withAnimation {
            opacity = 1.0
          }
        }
      }
  }
  
  var expenseList: some View {
    GeometryReader { proxy in
      UIScrollViewWrapper {
        HStack {
          Text("\(startDate.formatDate()) to \(endDate.formatDate())")
            .font(.title2)
            .padding(.leading)
          Spacer()
        }
        ForEach(corevm.dateRangeExpenses) { expense in
          HStack {
            Text(expense.wrappedDate.formatDate())
              .font(.caption)
              .frame(width: proxy.size.width * 0.15)
            Divider()
            Text(expense.wrappedVendor)
              .font(.caption)
              .frame(width: proxy.size.width * 0.25)
            Divider()
            Text(expense.wrappedCategory)
              .font(.caption)
              .frame(width: proxy.size.width * 0.25)
            Spacer()
            let costString = formatter.string(from: NSNumber(value: expense.cost))!
            Text(costString)
              .font(.caption)
          }
        }
        Divider()
        HStack {
          Text("Total:")
            .padding(.leading )
          Spacer()
          Text("$"+String(format: "%.2f", corevm.dateRangeTotal))
        }
      }
    }
  }
}
    
    
    struct ReportsView_Previews: PreviewProvider {
      static var previews: some View {
        ReportsView(corevm: CoreDataViewModel(), startDate: Date.now, endDate: Date.now)
      }
    }
