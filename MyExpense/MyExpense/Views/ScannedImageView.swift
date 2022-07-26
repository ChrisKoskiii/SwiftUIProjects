//
//  ScannedImageView.swift
//  MyExpense
//
//  Created by Christopher Koski on 7/26/22.
//

import SwiftUI

struct ScannedImageView: View {
  var selectedImage: UIImage
  
  var body: some View {
    Image(uiImage: selectedImage)
      .resizable()
      .scaledToFit()
  }
}

struct ScannedImageView_Previews: PreviewProvider {
  static var previews: some View {
    ScannedImageView(selectedImage: UIImage(systemName: "photo")!)
  }
}
