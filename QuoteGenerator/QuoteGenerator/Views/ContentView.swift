//
//  ContentView.swift
//  QuoteGenerator
//
//  Created by Christopher Koski on 6/27/22.
//

import SwiftUI

struct ContentView: View {
  @StateObject var quote = SharedQuote()
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("First Name", text: $quote.data.firstName)
          TextField("Last Name", text: $quote.data.lastName)
          TextField("Street Address", text: $quote.data.streetAddress)
          TextField("City", text: $quote.data.city)
        }
        
        Section {
          NavigationLink {
            DetailsView(quote: quote)
          } label : {
            Text("Next")
          }
        }
        .disabled(!quote.data.isFilledOut)
      }
      .navigationTitle("Get a quote")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
