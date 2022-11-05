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

    @State var score = 0

    var body: some View {
        VStack {
//            if startView {
//                StartView(startView: $startView, gameView: $gameView)
//            } else if gameView {
//                GameView(gameView: $gameView, gameOverView: $gameOverView, score: $score)
//            } else if gameOverView {
//                //GameOverView(score: score)
//            }
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
