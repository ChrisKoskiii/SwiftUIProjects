//
//  LocationCell.swift
//  DubDubGrub
//
//  Created by Christopher Koski on 8/10/22.
//

import SwiftUI

struct LocationCell: View {
  
  var location: DDGLocation
  
  var body: some View {
    HStack {
      Image("default-square-asset")
        .resizable()
        .scaledToFit()
        .frame(width: 80, height: 80)
        .clipShape(Circle())
        .padding(.vertical)
      VStack(alignment: .leading) {
        Text(location.name)
          .font(.title2)
          .fontWeight(.semibold)
          .lineLimit(1)
          .minimumScaleFactor(0.75)
        HStack {
          ForEach(0..<4) { _ in
            AvatarView(size: 25)
          }
        }
      }
      .padding(.leading)
    }
  }
}

struct LocationCell_Previews: PreviewProvider {
    static var previews: some View {
      LocationCell(location: DDGLocation(record: MockData.location))
    }
}
