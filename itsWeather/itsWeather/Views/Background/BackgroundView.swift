//
//  ContentView.swift
//  itsWeather
//
//  Created by Christopher Koski on 4/28/22.
//

import SwiftUI

struct BackgroundView: View {
  var body: some View {
    FloatingClouds()
  }
}

struct Cloud: View {
  @StateObject var provider = CloudProvider()
  @State var move = false
  
  let alignment: Alignment
  let proxy: GeometryProxy
  let color: Color
  
  //Animations
  let rotationStart: Double
  let duration: Double
  
  var body: some View {
    Circle()
      .fill(color)
      .frame(height: proxy.size.height / provider.frameHeightRatio)
      .offset(provider.offset)
      .rotationEffect(.init(degrees: move ? rotationStart : rotationStart + 360))
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
      .opacity(0.8)
      .onAppear() {
        withAnimation(.linear(duration: duration).repeatForever(autoreverses: false)) {
          move.toggle()
        }
      }
  }
}

class CloudProvider: ObservableObject {
  let offset: CGSize
  let frameHeightRatio: CGFloat
  
  init() {
    frameHeightRatio = CGFloat.random(in: 0.7..<1.4)
    offset = CGSize(width: CGFloat.random(in: -150..<150), height: CGFloat.random(in: -150..<150))
  }
}

struct FloatingClouds: View {
  @Environment(\.colorScheme) var scheme
  
  
  var body: some View {
    GeometryReader { proxy in
      ZStack {
        Theme.generalBackground
        Cloud(alignment: .topLeading,
              proxy: proxy,
              color: Theme.ellipsesTopLeading(forScheme: scheme),
              rotationStart: 0,
              duration: 20
        )
        Cloud(alignment: .topTrailing,
              proxy: proxy,
              color: Theme.ellipsesTopTrailing(forScheme: scheme),
              rotationStart: 0,
              duration: 20
        )
        Cloud(alignment: .bottomLeading,
              proxy: proxy,
              color: Theme.ellipsesBottomLeading(forScheme: scheme),
              rotationStart: 0,
              duration: 20
        )
        Cloud(alignment: .bottomTrailing,
              proxy: proxy,
              color: Theme.ellipsesBottomTrailing(forScheme: scheme),
              rotationStart: 0,
              duration: 20        )
      }
      .ignoresSafeArea()
      .overlay(.ultraThinMaterial)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    BackgroundView()
    BackgroundView()
      .preferredColorScheme(.dark)
  }
}
