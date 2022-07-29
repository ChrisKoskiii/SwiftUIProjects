//
//  AddItemSheet.swift
//  MyExpense
//
//  Created by Christopher Koski on 7/15/22.
//

import SwiftUI

struct AddItemView: View {
  
  @Environment(\.dismiss) var dismiss
  
  //ViewModel
  @ObservedObject var dataVM: DataController
  
  //ScannerView state helpers
  @State private var cameraIsPresented = false
  @State private var showScanner = false
  @State private var isRecognizing = false
  
  //Form entries
  @State private var dateValue: Date = Date()
  @State private var priceTextfield: Double = 0.0
  @State private var nameTextfield: String = ""
  @State private var categoryTextfield: String = ""
  @State private var vendorTextfield: String = ""
  
  @State private var imageArray: [UIImage] = []
  @State private var imageDataArray: [Data] = []

  var body: some View {
    VStack {
      Form {
        Section {
          DatePicker("Date", selection: $dateValue, displayedComponents: [.date])
        }
        Section {
          TextField("", value: $priceTextfield, format: .currency(code: "USD"))
        } header: {
          Text("What did it cost?")
        }
        Section {
          TextField("", text: $nameTextfield)
        } header: {
          Text("What is it for?")
        }
        Section {
          HStack {
            TextField("Category", text: $categoryTextfield)
            Picker("", selection: $categoryTextfield) {
              ForEach(dataVM.savedCategories, id: \.self) {
                Text($0.wrappedName)
              }
            }
            .pickerStyle(.menu)
          }
        } header: {
          Text("What category?")
        }
        Section {
          HStack {
            TextField("Vendor", text: $vendorTextfield)
            Picker("", selection: $vendorTextfield) {
              ForEach(dataVM.savedVendors, id: \.self) {
                Text($0.wrappedName)
              }
            }
            .pickerStyle(.menu)
          }
        } header: {
          Text("Where did you buy?")
        }
        Section {
          Button {
            showScanner = true
          } label: {
            HStack {
              Spacer()
              HStack {
                Image(systemName: "doc.text.viewfinder")
                  .renderingMode(.template)
                  .foregroundColor(.white)
                Text("Scan")
                  .foregroundColor(.white)
              }
              .padding(.horizontal, 16)
              .frame(height: 36)
              .background(Color(UIColor.systemIndigo))
              .cornerRadius(18)
              Spacer()
            }
          }
        }
        
        Section {
          if imageArray.isEmpty {
            Image(systemName: "photo")
              .resizable()
              .frame(width:80, height: 80)
              .scaledToFit()
              .foregroundColor(.secondary)
          } else {
            NavigationLink(destination: ScannedImageView(selectedImage: imageArray[0])) {
              ForEach(imageArray, id: \.self) { image in
                Image(uiImage: image)
                  .resizable()
                  .frame(width: 80, height: 80)
                  .clipShape(RoundedRectangle(cornerRadius: 20))
              }
            }
          }
          Spacer()
        }
      }
      .listRowBackground(Color.clear)
      HStack {
        Spacer()
        Button("Add Item"){
          dataVM.addExpense(name: nameTextfield, price: priceTextfield, date: dateValue, vendor: vendorTextfield, category: categoryTextfield, receipt: imageDataArray)
          dismiss()
        }
        Spacer()
      }
      .listRowBackground(Color.clear)
    }
    .onAppear {
      //Fetches current list of categories and vendors
      dataVM.getVendors()
      dataVM.getCategories()
    }
    .sheet(isPresented: $showScanner, content: {
      ScannerView { result in
        switch result {
        case .success(let scannedImages):
          isRecognizing = true
          imageArray = scannedImages
          imageDataArray = convertImageToData(images: scannedImages)
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
  
  func convertImageToData(images: [UIImage]) -> [Data] {
    var dataArray: [Data] = []
    for image in images {
      dataArray.append(image.jpegData(compressionQuality: 1.0)!)
    }
    return dataArray
  }
}

//  func checkEmpties() -> Bool {
//    if expenseName.count == 0 || price <= 0.0 || categoryName.count == 0 || vendorName.count == 0 {
//      //present eror
//      return false
//    }
//    return true
//  }

struct AddItemSheet_Previews: PreviewProvider {
  static var previews: some View {
    AddItemView()
  }
}
