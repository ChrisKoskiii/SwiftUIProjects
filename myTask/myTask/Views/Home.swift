//
//  Home.swift
//  myTask
//
//  Created by Christopher Koski on 5/12/22.
//

import SwiftUI

struct Home: View {
  
  @State var currentDate: Date = Date()
  
    var body: some View {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: 20) {
          CustomDatePicker(currentDate: $currentDate)
        }
      }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
