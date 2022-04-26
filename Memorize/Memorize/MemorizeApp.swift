//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Christopher Koski on 1/27/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
  let game = EmojiMemoryGame()
  
    var body: some Scene {
        WindowGroup {
            ContentView(game: game)
        }
    }
}
