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
  @FetchRequest(sortDescriptors: []) var lists: FetchedResults<ItemList>
  
  init() {
    UITableView.appearance().backgroundColor = .clear
  }
  @State var showingItemSheet = false
  @State var showingFolderSheet = false
  var body: some View {
    NavigationView {
      VStack {
        List(items) { item in
          HStack {
            Text(item.wrappedTitle)
              .strikethrough(item.isDone ? true : false)
            Spacer()
            Image(systemName: item.isDone ? "checkmark.circle.fill" : "checkmark.circle")
          }
          .onTapGesture {
            item.isDone.toggle()
            updateCache()
          }
        }
        List(lists) { list in
          Text(list.wrappedTitle)
        }
      }
      .navigationTitle("To-Do")
      .toolbar {
        ToolbarItem(placement: .primaryAction) {
          Button {
            showingItemSheet.toggle()
          } label: {
            Image(systemName: "plus")
          }
        }
        ToolbarItem {
          Button {
            showingFolderSheet.toggle()
          } label: {
            Image(systemName: "folder.badge.plus")
          }
        }
      }
      .sheet(isPresented: $showingItemSheet) {
        AddItemSheet()
      }
      .sheet(isPresented: $showingFolderSheet) {
        AddFolderSheet()
      }
    }
  }
  func updateCache() {
    try? moc.save()
  }
}

struct AddItemSheet: View {
  @Environment(\.dismiss) var dismiss
  @Environment(\.managedObjectContext) var moc
  
  @State private var taskTitle = ""
  var body: some View {
    ZStack {
      VStack {
        TextField("Enter task", text: $taskTitle)
          .multilineTextAlignment(.center)
      }
      VStack {
        Spacer()
        Button("Add Task") {
          saveItem()
          dismiss()
        }
      }
    }
  }
  func saveItem() {
    let newItem = Item(context: moc)
    newItem.id = UUID()
    newItem.title = taskTitle
    newItem.isDone = false
//    newItem.list = //
    
    try? moc.save()
  }
}

struct AddFolderSheet: View {
  @Environment(\.dismiss) var dismiss
  @Environment(\.managedObjectContext) var moc
  
  @State private var folderTitle = ""
  var body: some View {
    ZStack {
      VStack {
        Text("Create a folder")
        TextField("Enter task", text: $folderTitle)
          .multilineTextAlignment(.center)
      }
      VStack {
        Spacer()
        Button("Add Folder") {
          saveFolder()
          dismiss()
        }
      }
    }
  }
  func saveFolder() {
    let newFolder = ItemList(context: moc)
    newFolder.title = folderTitle
    
    try? moc.save()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
