//
//  ContentView.swift
//  Memorize
//
//  Created by Christopher Koski on 1/27/22.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var game: EmojiMemoryGame
  
  var body: some View {
    //    ScrollView {
    //      LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
    //        ForEach(viewModel.cards) { card in
    AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
      CardView(card: card)
        .padding(4)
        .onTapGesture {
          game.choose(card)
        }
    })
    //        }
    //      }
    //    }
      .foregroundColor(.red)
      .padding(.horizontal)
  }
}

struct CardView: View {
  let card: MemoryGame<String>.Card
  var body: some View {
    ZStack {
      let shape = RoundedRectangle(cornerRadius: 20)
      
      if card.isFaceUp {
        shape.fill(.white)
        shape.strokeBorder(lineWidth: 3)
        Text(card.content).font(.largeTitle)
      } else if card.isMatched {
        shape.opacity(0)
      } else {
        shape
      }
    }
  }
  
  private func font(in size: CGSize) -> Font {
    Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
  }

  private struct DrawingConstants {
    static let cornerRadius: CGFloat = 10
    static let lineWidth: CGFloat = 3
    static let fontScale: CGFloat = 0.75
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let game = EmojiMemoryGame()
    ContentView(game: game)
      .preferredColorScheme(.light)
      .previewInterfaceOrientation(.portrait)
    ContentView(game: game)
      .preferredColorScheme(.dark)
  }
}
