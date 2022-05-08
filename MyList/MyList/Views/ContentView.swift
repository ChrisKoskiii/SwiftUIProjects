//
//  ContentView.swift
//  MyList
//
//  Created by Christopher Koski on 5/5/22.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var vm = ViewModel()
  
  @State var myArray: [Item] = []
  var body: some View {
    ZStack {
      BackgroundView()
      VStack(alignment: .trailing, spacing: 8) {
        TopToolBar(vm: vm)
        ItemsList(vm: vm)
      }
    }
  }
}

struct TopToolBar: View {
  @ObservedObject var vm: ViewModel
  
  @State private var showingSheet = false
  var body: some View {
    HStack(spacing: 8) {
      Button {
        showingSheet.toggle()
      } label : {
        Image(systemName: "plus")
          .resizable()
          .frame(width: 24, height: 24)
          .foregroundStyle(LinearGradient(colors: [.blue, .pink], startPoint: .topLeading, endPoint: .bottomTrailing))
          .padding(.all, 12)
          .background(Circle().fill(.ultraThinMaterial))
      }
      .padding(.trailing)
      .sheet(isPresented: $showingSheet) {
        AddItemView(vm: vm)
      }
    }
  }
}

struct ItemsList: View {
  @ObservedObject var vm: ViewModel

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 8) {
        ForEach(vm.itemsArray) { item in
          Text(item.name)
            .onTapGesture {
            }
        }
        .padding(.leading)
        .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
  }
}


struct ItemCell: View {
  var item: Item
  var body: some View {
    Text(item.name)
      .font(.title)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var vm = ViewModel()
  static var previews: some View {
    ContentView(vm: vm)
  }
}

