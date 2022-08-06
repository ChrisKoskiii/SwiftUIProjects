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
  
  var detailExpense: ExpenseEntity?
  let buttonColor = Color("AddButtonColor")
  //Scanner state
  @State private var cameraIsPresented = false
  @State private var showScanner = false
  @State private var isRecognizing = false
  @State private var presentAlert = false
  //Textfield vars
  @State private var titleText: String = ""
  @State private var costText = 0.00
  @State private var vendorText: String = ""
  @State private var categoryText: String = ""
  @State private var dateValue: Date = Date.now
  
  private var dateString: String {
    dateValue.formatDate()
  }
  
  //Scanned image vars
  @State private var imageData: Data?
  @State private var scannedImage: UIImage?
  
  //Currency textfield formatter
  var formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.maximumFractionDigits = 2
    return formatter
  }()
  
  var body: some View {
    ZStack {
      
      BackgroundView()
      
      ScrollView {
        VStack(spacing: 10) {
          DatePicker(dateValue.formatDate(), selection: $dateValue, displayedComponents: [.date])
            .textfieldStyle()
          TextField("Enter title", text: $titleText)
            .textfieldStyle()
          
          TextField("$", value: $costText, formatter: formatter)
            .textfieldStyle()
            .keyboardType(.decimalPad)
          
          TextField("Enter vendor", text: $vendorText)
            .textfieldStyle()
          TextField("Enter category", text: $categoryText)
            .textfieldStyle()
          
          scanButton
          
          addExpenseButton
          
          if scannedImage != nil {
            scannedImageView
          }
          
          Spacer()
        }
      }
    }
    
    .navigationTitle("Add expense")
    .alert("Please fill out all fields.", isPresented: $presentAlert, actions: {
    })
    .sheet(isPresented: $showScanner, content: {
      ScannerView { result in
        switch result {
        case .success(let scannedImages):
          isRecognizing = true
          scannedImage = scannedImages.first!
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
    //Couldnt think of a cleaner way to add with or without an image
    Button {
      if emptyTextFields() {
        presentAlert.toggle()
        print(emptyTextFields())
        print(titleText)
        print(costText as Any)
        print(vendorText)
        print(categoryText)
      } else {
        if imageData != nil {
          vm.addExpense(title: titleText,
                        cost: costText,
                        vendor: vendorText,
                        category: categoryText,
                        date: dateValue,
                        receipt: imageData!
          )
          presentationMode.wrappedValue.dismiss()
        } else {
          vm.addExpenseWithoutImage(title: titleText,
                                    cost: costText,
                                    vendor: vendorText,
                                    category: categoryText,
                                    date: dateValue
          )
          presentationMode.wrappedValue.dismiss()
        }
      }
      } label: {
        Text("Add Expense")
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
  
  func emptyTextFields() -> Bool {
    if titleText.isEmpty ||
        vendorText.isEmpty ||
        categoryText.isEmpty {
      return true
    } else { return false
    }
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
