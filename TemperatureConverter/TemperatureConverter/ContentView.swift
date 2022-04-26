//
//  ContentView.swift
//  TemperatureConverter
//
//  Created by Christopher Koski on 4/26/22.
//

import SwiftUI

struct ContentView: View {
  @State var startingTemp = 0
  @State var startingUnit = "Kelvin"
  @State var convertingUnit = "Kelvin"

  var convertedTemp: Int {
    var result = 0
    if startingUnit == "Kelvin" && convertingUnit == "Celsius" {
      result = startingTemp - Int(273.15)
      return result
    } else if startingUnit == "Kelvin" && convertingUnit == "Fahrenheit" {
      result = (startingTemp - Int(273.15)) * 9 / 5 + 32
      return result
    } else if startingUnit == "Celsius" && convertingUnit == "Kelvin" {
      result = startingTemp + Int(273.15)
      return result
    } else if startingUnit == "Celsius" && convertingUnit == "Fahrenheit" {
      result = (startingTemp * Int(1.8)) + 32
      return result
    } else if startingUnit == "Fahrenheit" && convertingUnit == "Kelvin" {
      result = (((startingTemp - 32) * 5) / 9) + 273
      return result
    } else if startingUnit == "Fahrenheit" && convertingUnit == "Celsius" {
      result = (startingTemp - 32) / Int(1.8)
      return result
    } else  {
      result = startingTemp
      return result
    }
  }
  
  var units = ["Kelvin", "Celsius", "Fahrenheit"]
  
  var convertedTempAsString: String {
    let string = String(convertedTemp)
    return string
  }
  
  var body: some View {
    
    NavigationView {
      Form {
        Section {
          TextField("Starting Temperature", value: $startingTemp, format: .number)
            .multilineTextAlignment(.center)
            .keyboardType(.decimalPad)
          Picker("Starting Units", selection: $startingUnit) {
            ForEach(units, id: \.self) {
              Text($0)
            }
          }
          .pickerStyle(.segmented)
        } header : {
          Text("Starting Temperature")
        }
        Section {
          Text(convertedTempAsString)
            .frame(maxWidth: .infinity, alignment: .center)
          Picker("Starting Units", selection: $convertingUnit) {
            ForEach(units, id: \.self) {
              Text($0)
            }
          }
          .pickerStyle(.segmented)
        } header: {
          Text("Convert to...")
        }
      }
      .navigationTitle("Temperature Converter")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(startingTemp: 75)
  }
}
