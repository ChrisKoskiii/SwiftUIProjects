//
//  DocumentScanner.swift
//  MyExpense
//
//  Created by Christopher Koski on 7/25/22.
//

import SwiftUI
import VisionKit

struct DocumentScanner: UIViewControllerRepresentable {
  
  class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
      
    }
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
      
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
      
    }
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator()
  }
  
  func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
    let scannerView = VNDocumentCameraViewController()
    scannerView.delegate = context.coordinator
    return scannerView
  }
  
  func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
   
  }
  
  typealias UIViewControllerType = VNDocumentCameraViewController
  
  
}
