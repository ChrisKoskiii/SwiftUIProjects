//
//  Shapes.swift
//  Weatha
//
//  Created by Christopher Koski on 3/26/22.
//

import SwiftUI

struct RoundTrim: View {
  var body: some View {
    Circle()
      .stroke(lineWidth: 2)
      .frame(width: 50, height: 50)
  }
}

struct Shapes_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      RoundTrim()
      Image(systemName: "")
        .resizable()
        .frame(width: 30, height: 30)
        .padding()
    }
  }
}
