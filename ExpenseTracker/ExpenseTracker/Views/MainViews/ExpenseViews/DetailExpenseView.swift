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
  
  //scanner states
  @State private var cameraIsPresented = false
  @State private var showScanner = false
  @State private var isRecognizing = false
  
  //Textfield & picker values
  @State var titleText: String
  @State var costText: Double?
  @State var vendorText: String
  @State var categoryText: String
  @State var sentDate: Date
  @State var dateValue: Date = Date.now
  
  private var dateString: String {
    dateValue.formatDate()
  }
  
  //Image vars

  @State private var scannedImage: UIImage?
  @State var imageData: Data?
  
  //Current textfield formatter
  var formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    return formatter
  }()
  
  var body: some View {
    ZStack {
      
      BackgroundView()
      
      ScrollView {
        VStack(spacing: 10) {
          
          expenseTextfields
          
          scanButton
          
          addExpenseButton
          
          if scannedImage != nil {
            scannedImageView
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
          scannedImage = scannedImages.first
          imageData = vm.getImageData(scannedImage!)
        case .failure(let error):
          print(error.localizedDescription)
        }
        
        showScanner = false
        
      } didCancelScanning: {
        // Dismiss the scanner controller and the sheet.
        showScanner = false
      }
    })
    .task {
      await convertData()
    }
  }
  
  var expenseTextfields: some View {
    Group {
      DatePicker(dateValue.formatDate(), selection: $dateValue, displayedComponents: [.date])
        .textfieldStyle()
      TextField("Enter title", text: $titleText)
        .textfieldStyle()
      TextField("Enter cost", value: $costText, formatter: formatter)
        .textfieldStyle()
        .keyboardType(.decimalPad)
      TextField("Enter vendor", text: $vendorText)
        .textfieldStyle()
      TextField("Enter category", text: $categoryText)
        .textfieldStyle()
    }
  }
  
  var scanButton: some View {
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
      .scanButtonStyle()
    }
  }
  
  var addExpenseButton: some View {
    Button {
      if imageData != nil {
        vm.updateExpense(entity: detailExpense, title: titleText,
                         cost: costText!,
                         vendor: vendorText,
                         category: categoryText,
                         date: dateValue,
                         receipt: imageData!)
        presentationMode.wrappedValue.dismiss()
      } else {
        vm.updateExpenseWithoutImage(entity: detailExpense,
                                     title: titleText,
                                     cost: costText!,
                                     vendor: vendorText,
                                     category: categoryText,
                                     date: dateValue
        )
      }
    } label: {
      Text("Update Expense")
        .addButtonStyle()
    }
  }
  
  var scannedImageView: some View {
    NavigationLink(destination: ScannedImageView(scannedImage: scannedImage!)) {
      Image(uiImage: scannedImage!)
        .resizable()
        .scaledToFit()
        .frame(width: 150, height: 150)
    }
  }
  
  func convertData() async -> () {
    guard let imageData = imageData else {
      return
    }
    guard let convertedImage = UIImage(data: imageData) else { return }
    scannedImage = convertedImage
  }
  
  func emptyTextFields() -> Bool {
    if titleText.isEmpty ||
        costText == nil ||
        vendorText.isEmpty ||
        categoryText.isEmpty {
      return true
    } else { return false
    }
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
