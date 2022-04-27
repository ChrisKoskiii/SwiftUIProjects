//
//  ContentView.swift
//  DesignCodeiOS15
//
//  Created by Christopher Koski on 4/26/22.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 8.0) {
      Spacer()
      Image("Logo 2")
        .resizable(resizingMode: .stretch)
        .aspectRatio(contentMode: .fit)
        .frame(width: 26.0, height: 26.0)
        .cornerRadius(20.0)
      Text("SwiftUI iOS 15")
        .font(.largeTitle)
        .fontWeight(.bold)
      Text("20 sections - 3 hours")
        .font(.footnote)
        .fontWeight(.semibold)
      Text("Design and code a SwiftUI 3 app with custom layouts, animations and gestures using Xcode 13, SF Symbols 3, Canvas, Concurrency, Searchable and a whole lot more")
        .font(.footnote)
          .multilineTextAlignment(.leading)
          .lineLimit(2)
    }
    .padding(.all, 20.0)
    .frame(height: 350.0)
    .background(Color("Background"))
    .cornerRadius(30.0)
    .shadow(radius: 20)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
