//
//  FinishView.swift
//  QuoteGenerator
//
//  Created by Christopher Koski on 6/27/22.
//

import SwiftUI
import iPhoneNumberField

struct FinishView: View {
  @ObservedObject var quote: SharedQuote
  @State private var confirmationMessage = ""
  @State private var showingConfirmation = false
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          iPhoneNumberField(text: $quote.data.phoneNumber)
          TextField("Email", text: $quote.data.email)
        } header : {
          Text("We need your contact info")
        }
        
        Section {
          Button("Get Quote!") {
            Task {
              await getQuote()
            }
          }
          .disabled(quote.data.getQuoteDisabled)
        }
      }
    }
    .alert("Request sent", isPresented: $showingConfirmation) {
      Button("OK") { }
    } message: {
      Text(confirmationMessage)
    }
  }
  func getQuote() async {
    //1. convert quote object to JSON
    guard let encoded = try? JSONEncoder().encode(quote.data) else {
      print("Error encoding data")
      return
    }
    
    //2. Tell swift how to send over network
    let url = URL(string: "https://reqres.in/api/cupcakes")!
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    request.httpMethod = "POST"
    
    //3. Run the request and response
    do {
      let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
      let decodedQuote = try JSONDecoder().decode(Quote.self, from: data)
      confirmationMessage = "Thanks \(decodedQuote.firstName), your quote for \(decodedQuote.streetAddress) is being processed."
      showingConfirmation = true
    } catch {
      print("Connection failed")
    }
  }
}
struct FinishView_Previews: PreviewProvider {
  static var previews: some View {
    FinishView(quote: SharedQuote())
  }
}
