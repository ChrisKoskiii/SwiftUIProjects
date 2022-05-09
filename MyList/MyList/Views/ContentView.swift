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
  @State private var offsets = [CGSize](repeating: CGSize.zero, count: 6)
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 8) {
        ForEach(vm.itemsArray) { item in
          ItemCell(vm : vm, item: item)
        }
        .padding(.leading)
        .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
  }
}


struct ItemCell: View {
  @ObservedObject var vm: ViewModel
  var item: Item
  var body: some View {
    ZStack(alignment: .leading) {
    Text(item.name)
        .font(.title)
      .onTapGesture {
        withAnimation(.easeInOut) {
          vm.updateItem(item: item)
        }
      }
      .onDelete {
        vm.deleteItem(item: item)
      }
      RoundedRectangle(cornerRadius: 20)
        .fill(LinearGradient(colors: [.red.opacity(0.8), .red.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing))
        .frame(width: item.name.widthOfString(usingFont: UIFont.systemFont(ofSize: 28)), height: 4)
        .opacity(item.isDone ? 1.0 : 0.0)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var vm = ViewModel()
  static var previews: some View {
    ContentView(vm: vm)
  }
}

