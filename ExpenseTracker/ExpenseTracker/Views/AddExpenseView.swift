//
//  AddExpenseView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/28/22.
//

import SwiftUI

struct AddExpenseView: View {
  @Environment(\.presentationMode) var presentationMode
  
  @ObservedObject var vm: CoreDataViewModel

  @State private var cameraIsPresented = false
  @State private var showScanner = false
  @State private var isRecognizing = false
  
  @State private var titleText: String = ""
  @State private var costText: Double = 0.0
  @State private var vendorText: String = ""
  @State private var categoryText: String = ""
  @State private var dateValue: Date = Date.now
  
  @State private var imageArray: [UIImage] = []
  @State private var imageDataArray: [Data] = []
  
  var detailExpense: ExpenseEntity?
  
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
            vm.addExpense(title: titleText,
                          cost: costText,
                          vendor: vendorText,
                          category: categoryText,
                          date: dateString)
            presentationMode.wrappedValue.dismiss()
          } label: {
            Text("Add Expense")
              .buttonStyle()
          }
          Spacer()
        }
      }
    }
    .navigationTitle("Add expense")
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


struct AddExpenseView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      AddExpenseView(vm: CoreDataViewModel())
    }
    NavigationView {
    AddExpenseView(vm: CoreDataViewModel())
    }
    .preferredColorScheme(.dark)
  }
}
