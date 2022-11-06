//
//  ContentView.swift
//  NinjaBattle
//
//  Created by Anton Saltykov on 04.11.2022.
//

import SwiftUI

enum Page {
    case start, game, gameOver
}

struct ContentView: View {

    @State private var page = Page.start
    @State private var score = 0

    var body: some View {
        VStack {
            switch page {
            case .start:
                StartView(page: $page)
            case .game:
                GameView(page: $page, score: $score)
            case .gameOver:
                GameOverView(page: $page, score: $score)
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
