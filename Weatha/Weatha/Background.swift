//
//  Background.swift
//  Weatha
//
//  Created by Christopher Koski on 3/26/22.
//

import SwiftUI

struct BackgroundGradient: View {
  var body: some View {
    LinearGradient(gradient: Gradient(colors: [Color("Color4"), Color("Color3")]), startPoint: .top, endPoint: .bottom)
      .edgesIgnoringSafeArea(.all)
  }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundGradient()
    }
}
