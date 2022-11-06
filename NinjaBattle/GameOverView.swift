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

    @AppStorage("maxScore") var maxScore: Int = 0

    @State private var currentMaxScore = 0

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

                Text(score > currentMaxScore ? "Новый рекорд!" : "Рекорд: \(currentMaxScore)")
                    .onAppear {
                        currentMaxScore = maxScore
                        // Сохраняем текущий рекорд
                        if score > maxScore {
                            maxScore = score
                        }
                    }

                ActionButtonView(actionButtonText: "ЗАНОВО",
                                 actionButtonDisabled: false) {
                    score = 0
                    withAnimation {
                        page = .game
                    }
                }

                ActionButtonView(actionButtonText: "ДОМОЙ",
                                 actionButtonDisabled: false) {
                    score = 0
                    withAnimation {
                        page = .start
                    }

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
