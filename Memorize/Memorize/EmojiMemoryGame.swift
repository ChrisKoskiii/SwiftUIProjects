//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Christopher Koski on 1/31/22.
//

import SwiftUI

//this is the viewModel

class EmojiMemoryGame: ObservableObject {
  
  static let emojis = ["✈️", "🏎", "🚓", "🚒", "🚀", "🚜", "🛳", "🚎", "🚁", "🚕", "🛺", "🛵", "🚌", "🚐", "🛴", "🛻", "🚤"]
  
  static func createMemoryGame() -> MemoryGame<String> {
    MemoryGame<String>(numberOfPairsOfCards: 8) { pairIndex in emojis[pairIndex] }
  }
  
  @Published private var model: MemoryGame<String> = createMemoryGame()
  
  var cards: Array<MemoryGame<String>.Card> {
    return model.cards
  }
  
  // MARK: - Intent(s)
  
  func choose(_ card: MemoryGame<String>.Card) {
    model.choose(card)
  }
}
