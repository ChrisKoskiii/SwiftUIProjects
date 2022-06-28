//
//  DetailsView.swift
//  QuoteGenerator
//
//  Created by Christopher Koski on 6/27/22.
//

import SwiftUI

struct DetailsView: View {
  @ObservedObject var quote: SharedQuote
  
  var body: some View {
    Form {
      Section {
        Picker("How many stories?", selection: $quote.data.outsideOnly) {
          Text("Exterior Only")
          Text("Interior & Exterior")
        }
        .pickerStyle(.segmented)
      } header: {
        Text("Interior & Exterior?")
      }
      
      Section {
        Picker("How many stories?", selection: $quote.data.stories) {
          ForEach(1...3, id: \.self) { number in
            Text("\(number)")
          }
        }
        .pickerStyle(.segmented)
      } header: {
        Text("How many stories?")
      }
      
      Section {
        TextField("Enter count", value: $quote.data.sliders, formatter: NumberFormatter())
      } header: {
        Text("How many sliding glass door panes?")
      }
      
      Section {
        TextField("Enter count", value: $quote.data.windows, formatter: NumberFormatter())
      } header: {
        Text("How many regular sized windows?")
      }
      
      Section {
        NavigationLink {
          FinishView(quote: quote)
        } label: {
          Text("Next")
        }
      }
    }
  }
}

struct DetailsView_Previews: PreviewProvider {
  static var previews: some View {
    DetailsView(quote: SharedQuote())
  }
}
