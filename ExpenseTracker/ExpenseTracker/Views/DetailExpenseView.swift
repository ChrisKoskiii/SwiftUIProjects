//
//  DetailExpenseView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/30/22.
//

import SwiftUI

struct DetailExpenseView: View {
  @Environment(\.presentationMode) var presentationMode
  
  @ObservedObject var vm: CoreDataViewModel
  
  @State var detailExpense: ExpenseEntity
  
  @State private var cameraIsPresented = false
  @State private var showScanner = false
  @State private var isRecognizing = false
  
  @State var titleText: String
  @State var costText: Double
  @State var vendorText: String
  @State var categoryText: String
  @State var sentDate: String
  
  @State var dateValue: Date = Date.now
  
  @State private var imageArray: [UIImage] = []
  @State private var imageDataArray: [Data] = []
  
  private var dateString: String {
    dateValue.formatDate()
  }
  
  var body: some View {
    ZStack {
      BackgroundView()
      ScrollView {
        VStack(spacing: 10) {
          DatePicker(dateValue.formatDate(), selection: $dateValue, displayedComponents: [.date])
            .textfieldStyle()
          TextField("Enter title", text: $titleText)
            .textfieldStyle()
          TextField("Enter cost", value: $costText, format: .number)
            .textfieldStyle()
          TextField("Enter vendor", text: $vendorText)
            .textfieldStyle()
          TextField("Enter category", text: $categoryText)
            .textfieldStyle()
          
          Button {
            showScanner = true
          } label: {
            HStack {
              Image(systemName: "doc.text.viewfinder")
                .renderingMode(.template)
                .foregroundColor(.white)
              Text("Scan")
                .foregroundColor(.white)
            }
            .buttonStyle()
          }
          Button {
            vm.updateExpense(entity: detailExpense, title: titleText,
                          cost: costText,
                          vendor: vendorText,
                          category: categoryText,
                          date: dateString)
            presentationMode.wrappedValue.dismiss()
          } label: {
            Text("Update Expense")
              .buttonStyle()
          }
          Spacer()
        }
      }
    }
    .navigationTitle("Update expense")
    .sheet(isPresented: $showScanner, content: {
      ScannerView { result in
        switch result {
        case .success(let scannedImages):
          isRecognizing = true
          imageArray = scannedImages
        case .failure(let error):
          print(error.localizedDescription)
        }
        
        showScanner = false
        
      } didCancelScanning: {
        // Dismiss the scanner controller and the sheet.
        showScanner = false
      }
    })
  }
}


//struct DetailExpenseView_Previews: PreviewProvider {
//  static var previews: some View {
//    NavigationView {
//      DetailExpenseView(vm: CoreDataViewModel())
//    }
//    NavigationView {
//      DetailExpenseView(vm: CoreDataViewModel())
//    }
//    .preferredColorScheme(.dark)
//  }
//}
