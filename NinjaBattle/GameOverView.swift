//
//  GameOverView.swift
//  NinjaBattle
//
//  Created by Anton Saltykov on 05.11.2022.
//

import SwiftUI

struct GameOverView: View {

    @Binding var page: Page
    @Binding var score: Int


    var body: some View {
        ZStack {
            Rectangle()
                .fill(.orange.gradient)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Text("Game Over")
                    .font(.custom("AmericanTypewriter", fixedSize: 40)).bold(true)
                    .foregroundColor(.white)
                HStack {
                    Text("Ваш счет: ").font(.custom("AmericanTypewriter", fixedSize: 24))
                    Text(score.formatted())
                        .font(.custom("AmericanTypewriter", fixedSize: 24)).bold(true)
                }

                ActionButtonView(actionButtonText: "ЗАНОВО",
                                 actionButtonDisabled: false) {
                    score = 0
                    page = .game
                }
            }
        }
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(page: .constant(.gameOver), score: .constant(100))
    }
}
