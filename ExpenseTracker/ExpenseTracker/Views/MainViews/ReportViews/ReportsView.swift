//
//  ReportsView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/29/22.
//

import SwiftUI
import PDFGenerator

struct ReportsView: View {
  @ObservedObject var corevm: CoreDataViewModel
  @StateObject var reportsvm = ReportsViewModel()
  @State private var opacity = 0.0

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
            exportToPDF()
          } label : {
            Image(systemName: "square.and.arrow.up.fill")
          }
        }
      }
      .sheet(isPresented: $reportsvm.showShareSheet) {
        reportsvm.PDFUrl = nil
      } content: {
        if let PDFUrl = reportsvm.PDFUrl {
          ShareSheet(urls: [PDFUrl])
        }
      }
      .onAppear {
        corevm.getDateRangeExpenses(startDate: startDate, endDate: endDate)
        corevm.categoryTotal()
        DispatchQueue.main.async {
          withAnimation {
            opacity = 1.0
          }
        }
      }
  }
  
  var expenseList: some View {
    VStack {
      HStack {
        Text("\(startDate.formatDate()) to \(endDate.formatDate())")
          .font(.title2)
          .padding()
        Spacer()
      }
      
      let categories = corevm.categoriesDict.keys.sorted().map{Category(name: $0, cost: corevm.categoriesDict[$0]!)}
      ForEach(categories, id: \.name) { category in
        HStack {
          Text(category.name)
            .font(.caption)
            .padding(.leading )
            .lineLimit(0)
          Spacer()
          let costString = formatter.string(from: NSNumber(value: category.cost))!
          Text(costString)
            .font(.caption)
            .padding(.trailing)
        }
        Divider()
      }
      HStack {
        Text("Total:")
          .padding(.leading )
        Spacer()
        Text("$"+String(format: "%.2f", corevm.dateRangeTotal))
          .padding(.trailing)
      }
      Spacer()
    }
  }
  
  func exportToPDF() {
    
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let outputFileURL = documentDirectory.appendingPathComponent("SwiftUI.pdf")
    
    //Normal with
    let width: CGFloat = 8.5 * 72.0
    //Estimate the height of your view
    let height: CGFloat = 1000
    
    let pdfVC = UIHostingController(rootView: expenseList)
    pdfVC.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
    
    //Render the view behind all other views
    let rootVC = UIApplication.shared.windows.first?.rootViewController
    rootVC?.addChild(pdfVC)
    rootVC?.view.insertSubview(pdfVC.view, at: 0)
    
    //Render the PDF
    let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 8.5 * 72.0, height: height))
    
    do {
      try pdfRenderer.writePDF(to: outputFileURL, withActions: { (context) in
        context.beginPage()
        pdfVC.view.layer.render(in: context.cgContext)
      })
      
      self.reportsvm.PDFUrl = outputFileURL
      self.reportsvm.showShareSheet = true
      
    }catch {
      print("Could not create PDF file: \(error)")
    }
    
    pdfVC.removeFromParent()
    pdfVC.view.removeFromSuperview()
  }
  
}


struct ReportsView_Previews: PreviewProvider {
  static var previews: some View {
    ReportsView(corevm: CoreDataViewModel(), reportsvm: ReportsViewModel(), startDate: Date.now, endDate: Date.now)
  }
}

struct ReportExpenseView {
  var view: AnyView
}
