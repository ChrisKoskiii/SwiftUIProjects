//
//  ContentView.swift
//  ToDoCoreData
//
//  Created by Christopher Koski on 7/11/22.
//

import SwiftUI

struct ContentView: View {
  @Environment(\.managedObjectContext) var moc
  
  @FetchRequest(sortDescriptors: []) var items: FetchedResults<Item>
  @State var showingSheet = false
    var body: some View {
      NavigationView {
        List(items) { item in
          Text(item.wrappedTitle)
        }
        .navigationTitle("To-Do")
        .toolbar {
          ToolbarItem {
            Button {
              showingSheet.toggle()
            } label: {
              Image(systemName: "plus")
            }
          }
        }
        .sheet(isPresented: $showingSheet) {
          Text("Hi")
        }
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#error ("Create sheet View, textfield to enter item title, save item to coreData")
