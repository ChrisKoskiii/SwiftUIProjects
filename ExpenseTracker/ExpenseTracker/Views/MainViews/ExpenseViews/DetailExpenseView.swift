//
//  DetailExpenseView.swift
//  ExpenseTracker
//
//  Created by Christopher Koski on 7/30/22.
//

import SwiftUI

struct DetailExpenseView: View {
  @Environment(\.presentationMode) var presentationMode
  
  //ViewModels
  @ObservedObject var coreVM: CoreDataViewModel
  @ObservedObject var expensesVM: ExpensesViewModel
  
  @State var detailExpense: ExpenseEntity
  
  //scanner states
  @State private var cameraIsPresented = false
  @State private var showScanner = false
  @State private var isRecognizing = false
  
  private var dateString: String {
    detailExpense.wrappedDate.formatDate()
  }
  
  //Image vars
  
  @State private var scannedImage: UIImage?
  
  //Current textfield formatter
  var formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    return formatter
  }()
  
  @State private var showingAlert = false
  
  var body: some View {
    ScrollView {
      VStack(spacing: 10) {
        
        expenseTextfields
        
        scanButton
        
        updateExpenseButton
        
        if scannedImage != nil {
          scannedImageView
        }
        
        Spacer()
      }
    }
    .background(Color(.secondarySystemBackground))
    .navigationTitle("Update expense")
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem {
        Button {
          showingAlert.toggle()
        } label: {
          Image(systemName: "trash")
            .foregroundColor(.red)
        }
      }
    }
    .sheet(isPresented: $showScanner, content: {
      ScannerView { result in
        switch result {
        case .success(let scannedImages):
          isRecognizing = true
          scannedImage = scannedImages.first
          detailExpense.receipt = coreVM.getImageData(scannedImage!)
        case .failure(let error):
          print(error.localizedDescription)
        }
        showScanner = false
      } didCancelScanning: {
        showScanner = false
      }
    })
    .task {
      await convertData()
    }
    .alert("Are you sure you want to delete this expense?", isPresented: $showingAlert) {
      Button("Delete", role: .destructive) {
        coreVM.deleteExpense(detailExpense)
        coreVM.getDateRangeExpenses(
          startDate: expensesVM.monthStart,
          endDate: expensesVM.monthEnd) { expenses in
            expensesVM.dateRangeExpenses = expenses
          }
        presentationMode.wrappedValue.dismiss()
      }
      .foregroundColor(.red)
      Button("Cancel", role: .cancel) { }
    }
  }
  
  var expenseTextfields: some View {
    Group {
      DatePicker(dateString, selection: $detailExpense.wrappedDate, displayedComponents: [.date])
        .textfieldStyle()
      TextField("Enter title", text: $detailExpense.wrappedTitle)
        .textfieldStyle()
      TextField("Enter cost", value: $detailExpense.cost, formatter: formatter)
        .textfieldStyle()
        .keyboardType(.decimalPad)
      TextField("Enter vendor", text: $detailExpense.wrappedVendor)
        .textfieldStyle()
      TextField("Enter category", text: $detailExpense.wrappedCategory)
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
  
  var updateExpenseButton: some View {
    Button {
      if detailExpense.receipt != nil {
        coreVM.updateExpense(entity: detailExpense, title: detailExpense.wrappedTitle,
                             cost: detailExpense.cost,
                             vendor: detailExpense.wrappedVendor,
                             category: detailExpense.wrappedCategory,
                             date: detailExpense.wrappedDate,
                             receipt: detailExpense.receipt)
        presentationMode.wrappedValue.dismiss()
      } else {
        coreVM.updateExpenseWithoutImage(entity: detailExpense,
                                         title: detailExpense.wrappedTitle,
                                         cost: detailExpense.cost,
                                         vendor: detailExpense.wrappedVendor,
                                         category: detailExpense.wrappedCategory,
                                         date: detailExpense.wrappedDate)
        presentationMode.wrappedValue.dismiss()
      }
    } label: {
      Text("Update Expense")
        .addButtonStyle()
    }
  }
  
  var deleteButton: some View {
    Button {
      coreVM.deleteExpense(detailExpense)
      coreVM.getDateRangeExpenses(
        startDate: expensesVM.monthStart,
        endDate: expensesVM.monthEnd) { expenses in
          expensesVM.dateRangeExpenses = expenses
        }
      presentationMode.wrappedValue.dismiss()
    } label: {
      Text("Delete Expense")
        .deleteButtonStyle()
      
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
    guard let imageData = detailExpense.receipt else {
      return
    }
    guard let convertedImage = UIImage(data: imageData) else { return }
    scannedImage = convertedImage
  }
  
  func emptyTextFields() -> Bool {
    if detailExpense.wrappedTitle.isEmpty ||
        detailExpense.cost == 0.00 ||
        detailExpense.wrappedVendor.isEmpty ||
        detailExpense.wrappedCategory.isEmpty {
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
