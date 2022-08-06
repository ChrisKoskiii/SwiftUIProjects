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
  
  @State var PDFUrl: URL?
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
    ScrollView {
      expenseList
    }
    .navigationBarTitle("Generate Reports")
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem {
        Button {
          exportToPDF()
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
    ForEach(corevm.dateRangeExpenses) { expense in
      GeometryReader { proxy in
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
      HStack {
        Text("Total:")
        Spacer()
        Text("$"+String(format: "%.2f", corevm.dateRangeTotal))
      }
    }
  }
  
  func convertToScrollView<Content: View>(@ViewBuilder content: @escaping ()->Content)->UIScrollView{
    
    let scrollView = UIScrollView()
    
    // MARK: Converting SwiftUI View to UIKit View
    let hostingController = UIHostingController(rootView: content()).view!
    hostingController.translatesAutoresizingMaskIntoConstraints = false
    
    // MARK: Constraints
    let constraints = [
      
      hostingController.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      hostingController.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      hostingController.topAnchor.constraint(equalTo: scrollView.topAnchor),
      hostingController.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      
      // Width Anchor
      hostingController.widthAnchor.constraint(equalToConstant: screenBounds().width)
    ]
    scrollView.addSubview(hostingController)
    scrollView.addConstraints(constraints)
    scrollView.layoutIfNeeded()
    
    return scrollView
  }
  
  func exportToPDF() {
    let outputFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("SwiftUI.pdf")
    let pageSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    
    //View to render on PDF
    let myUIHostingController = UIHostingController(rootView: expenseList)
    myUIHostingController.view.frame = CGRect(origin: .zero, size: pageSize)
    
    
    //Render the view behind all other views
    guard let rootVC = UIApplication.shared.windows.first?.rootViewController else {
      print("ERROR: Could not find root ViewController.")
      return
    }
    rootVC.addChild(myUIHostingController)
    //at: 0 -> draws behind all other views
    //at: UIApplication.shared.windows.count -> draw in front
    rootVC.view.insertSubview(myUIHostingController.view, at: 0)
    
    
    //Render the PDF
    let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size: pageSize))
    DispatchQueue.main.async {
      do {
        try pdfRenderer.writePDF(to: outputFileURL, withActions: { (context) in
          context.beginPage()
          myUIHostingController.view.layer.render(in: context.cgContext)
        })
        print("wrote file to: \(outputFileURL.path)")
        PDFUrl = outputFileURL
      } catch {
        print("Could not create PDF file: \(error.localizedDescription)")
      }
      
      //Remove rendered view
      myUIHostingController.removeFromParent()
      myUIHostingController.view.removeFromSuperview()
    }
  }
  
  func screenBounds()->CGRect{
    return UIScreen.main.bounds
  }
  
  func getRootController()->UIViewController{
    guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
      return .init()
    }
    
    guard let root = screen.windows.first?.rootViewController else{
      return .init()
    }
    
    return root
  }
  
  func getSafeArea()->UIEdgeInsets{
    guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
      return .zero
    }
    
    guard let safeArea = screen.windows.first?.safeAreaInsets else{
      return .zero
    }
    
    return safeArea
  }
  
}

struct ReportsView_Previews: PreviewProvider {
  static var previews: some View {
    ReportsView(corevm: CoreDataViewModel(), startDate: Date.now, endDate: Date.now)
  }
}
