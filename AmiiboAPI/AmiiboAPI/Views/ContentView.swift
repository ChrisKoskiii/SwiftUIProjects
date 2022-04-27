//
//  ContentView.swift
//  AmiiboAPI
//
//  Created by Christopher Koski on 3/24/22.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var apiCall: apiCall
  
  
  var body: some View {
    Group {
      AmiiboListView(apiCall: apiCall)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(apiCall: apiCall())
  }
}

struct AmiiboListView: View {
  @ObservedObject var apiCall: apiCall
  
  var body: some View {
    let allAmiibos = apiCall.amiibos
    
    List(allAmiibos, id: \.self) { item in
      VStack {
        Text("Link")
          .font(.headline)
        Text("Legend of Zelda")
      }
    }
    .onAppear() {
      DispatchQueue.main.async {
        apiCall.getAmiibos { amiibo in
          
        }
      }
    }
  }
}
