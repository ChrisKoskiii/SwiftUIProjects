//
//  ContentView.swift
//  TestDocScanner
//
//  Created by Christopher Koski on 7/25/22.
//

import SwiftUI

struct ContentView: View {
  @State private var showScanner = false
  @State private var isRecognizing = false
  @State private var imageArray: [UIImage] = []
  var body: some View {
    NavigationView {
      ZStack(alignment: .bottom) {
        
        if isRecognizing {
          ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: Color(UIColor.systemIndigo)))
            .padding(.bottom, 20)
        }
        ForEach(imageArray, id:\.self) { image in
          Image(uiImage: image)
            .resizable()
            .scaledToFit()
        }
      }
      .navigationTitle("Text Scanner")
      .navigationBarItems(trailing: Button(action: {
        guard !isRecognizing else { return }
        showScanner = true
      }, label: {
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
      }))
    }
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

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
