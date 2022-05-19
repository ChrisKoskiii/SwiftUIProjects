//
//  AddItemView.swift
//  MyList
//
//  Created by Christopher Koski on 5/5/22.
//

import SwiftUI

struct AddItemView: View {
  @ObservedObject var vm: ViewModel
  @State var nameText: String = ""
  var body: some View {
    ZStack {
      AddItemViewBackround()
      VStack {
        Spacer()
        addItemTextField
        Spacer()
        AddButtonView(vm: vm, item: Item(name: nameText, isDone: false))
      }
      .font(.title)
      .padding()
    }
  }
  
  var addItemTextField: some View {
    TextField("Enter To Do Item", text: $nameText)
      .font(.title)
      .multilineTextAlignment(.center)
  }
}

struct AddItemViewBackround: View {
  @State var animateGradient = true
  var body: some View {
    LinearGradient(colors: [.pink.opacity(0.5), .blue.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)
      .hueRotation(.degrees(animateGradient ? 45 : 0))
      .ignoresSafeArea()
      .onAppear {
        withAnimation(.easeInOut(duration: 4.0).repeatForever(autoreverses: true)) {
          animateGradient.toggle()
        }
      }
  }
}
struct AddButtonView: View {
  @Environment(\.dismiss) var dismiss
  @ObservedObject var vm: ViewModel
  
  var item: Item
  var body: some View {
    Button {
      addItem(item)
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        dismiss()
      }
    } label: {
      HStack {
        Image(systemName: "plus.diamond")
          .foregroundStyle(LinearGradient(colors: [.blue, .pink], startPoint: .topLeading, endPoint: .bottomTrailing))
      }
      Text("Add Item")
        .foregroundStyle(LinearGradient(colors: [.primary, .primary.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing))
    }
    .padding()
    .background(
      .ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous)
    )
    .strokeStyle(cornerRadius: 16)
  }
  
  func addItem(_ item: Item) {
    vm.itemsArray.append(item)
  }
}

struct AddItemView_Previews: PreviewProvider {
  static var vm = ViewModel()
  static var previews: some View {
    AddItemView(vm: vm, nameText: "hello")
  }
}
