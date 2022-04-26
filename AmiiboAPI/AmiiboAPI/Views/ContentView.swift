//
//  ContentView.swift
//  AmiiboAPI
//
//  Created by Christopher Koski on 3/24/22.
//

import SwiftUI

struct ContentView: View {
  @State var amiibos = [Amiibo]()
  
  var body: some View {
    List(amiibos, id: \.self) { item in
      VStack {
        Text(item.name)
          .font(.headline)
        Text(item.gameSeries)
      }
    }
    .onAppear() {
      DispatchQueue.main.async {
        apiCall().getAmiibos { amiibo in
          
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
