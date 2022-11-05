//
//  GameView.swift
//  NinjaBattle
//
//  Created by Anton Saltykov on 04.11.2022.
//

import SwiftUI

enum WeaponDirection {
    case forward, back
}

struct GameView: View {

    private let baseSize = 100.0
    private let attackDuration = 0.6

    @State private var score = 0
    @State private var health = 3

    @State private var enemyPosition = 50.0


    @State private var playerPosition = Double(UIScreen.main.bounds.width / 2)
    @State private var isPlayerAttack = false
    @State private var playerAttackDirection: WeaponDirection = .forward
    @State private var playerAttackXPosition = 0.0

    var body: some View {
        ZStack {
            Color(.orange)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                ScoreBarView(score: score)

                GeometryReader {geometry in
                    EnemyView(enemyPosition: $enemyPosition, baseSize: baseSize)

                    // Weapon area


                    WeaponView()
                        .frame(width: baseSize / 2, height: baseSize / 2)
                        .position(
                            x: playerAttackDirection == .forward && isPlayerAttack
                            ? playerAttackXPosition
                            : playerPosition,
                            y: isPlayerAttack ? 110 : UIScreen.main.bounds.size.height - 320
                        )
                        .animation(.default, value: playerPosition)
                        .animation(
                            Animation.linear(duration: attackDuration),
                            value: isPlayerAttack
                        )
                        .opacity(playerAttackDirection == .forward && isPlayerAttack ? 1 : 0)



                    // Player
                    NinjaView()
                        .frame(width: baseSize, height: baseSize)
                        .position(x: playerPosition, y: geometry.size.height - 65)
                        .animation(.default, value: playerPosition)

                }
                ActionBarView(playerPosition: $playerPosition, baseSize: baseSize) {
                    playerAttack()
                }



            }
        }.onAppear {
            initPlayerPosition()
        }
    }
}

extension GameView {
    private func initPlayerPosition() {
        playerPosition = UIScreen.main.bounds.width / 2
    }

    private func playerAttack() {

        if isPlayerAttack || playerAttackDirection == .back {
            // TODO: Обработать нажатие атаки во время полета
            return
        }

        isPlayerAttack = true // Пропишем явно, чтобы не запутаться. Атака началась
        playerAttackDirection = .forward
        playerAttackXPosition = playerPosition

        // Состояние, когда сюрикен долетает до цели
        DispatchQueue.main.asyncAfter(deadline: .now() + attackDuration) {
            playerAttackDirection = .back
            isPlayerAttack = false
            if playerAttackXPosition <= enemyPosition + baseSize / 2 &&
                playerAttackXPosition >= enemyPosition - baseSize / 2 {
                score += 1
            }

        }

        // Состояние, когда сюрикен возвращается обратно к игроку
        DispatchQueue.main.asyncAfter(deadline: .now() + attackDuration * 2) {
            playerAttackDirection = .forward

        }
    }

}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

