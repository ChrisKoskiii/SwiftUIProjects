//
//  FinishView.swift
//  QuoteGenerator
//
//  Created by Christopher Koski on 6/27/22.
//

import SwiftUI

struct FinishView: View {
  @ObservedObject var quote: SharedQuote
  
    var body: some View {
        Form {
          Section {
            TextField("Phone Number", value: $quote.data.phoneNumber, formatter: NumberFormatter())
            TextField("Email", text: $quote.data.email)
          } header : {
            Text("We need your contact info")
          }
          
          Section {
            Button("Get Quote!") {
              //submit quote
            }
            .disabled(quote.data.getQuoteDisabled)
          }
        }
    }
}

struct FinishView_Previews: PreviewProvider {
    static var previews: some View {
      FinishView(quote: SharedQuote())
    }
}
