//
//  DocumentScanner.swift
//  TestDocScanner
//
//  Created by Christopher Koski on 7/25/22.
//

import SwiftUI
import VisionKit

struct ScannerView: UIViewControllerRepresentable {
  var didFinishScanning: ((_ result: Result<[UIImage], Error>) -> Void)
  var didCancelScanning: () -> Void
  static var scannedImages: [UIImage] = []
  
  func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
    let scannerViewController = VNDocumentCameraViewController()
    scannerViewController.delegate = context.coordinator
    return scannerViewController
  }
  
  func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) { }
  
  
  func makeCoordinator() -> Coordinator {
    Coordinator(with: self)
  }
  
  
  class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
    
    let scannerView: ScannerView
    
    init(with scannerView: ScannerView) {
      self.scannerView = scannerView
    }
    
    
    // MARK: - VNDocumentCameraViewControllerDelegate
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
      var scannedPages = [UIImage]()
      
      for i in 0..<scan.pageCount {
        scannedPages.append(scan.imageOfPage(at: i))
        scannedImages.append(scan.imageOfPage(at: i))
      }
      scannerView.didFinishScanning(.success(scannedPages))
    }
    
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
      scannerView.didCancelScanning()
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
      scannerView.didFinishScanning(.failure(error))
    }
  }
  
}
