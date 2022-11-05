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
    private let playerAttackDuration = 1.0

    @Binding var page: Page

    @Binding var score: Int
    @State private var health = 5

    @State private var enemyPosition = 50.0
    @State private var enemyAttackDuration = 1.0

    @State private var playerPosition = Double(UIScreen.main.bounds.width / 2)
    @State private var isPlayerAttack = false
    @State private var playerAttackDirection: WeaponDirection = .forward
    @State private var playerAttackXPosition = 0.0

    @State private var isEnemyAttack = false
    @State private var enemyAttackDirection: WeaponDirection = .forward
    @State private var enemyAttackXPosition = 0.0

    @State private var actionButtonText = "ATTACK"

    private var halfSize: Double {
        baseSize / 2
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.orange.gradient)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                ScoreBarView(score: score, health: health)

                GeometryReader {geometry in
                    EnemyView(enemyPosition: $enemyPosition, baseSize: baseSize)

                    EnemyWeaponView(size: halfSize,
                                    isEnemyAttack: isEnemyAttack,
                                    enemyAttackXPosition: enemyAttackXPosition,
                                    enemyPosition: enemyPosition,
                                    yPosition:  geometry.size.height - 80,
                                    attackDuration: enemyAttackDuration,
                                    enemyAttackDirection: enemyAttackDirection) {
                        self.enemyAttack()
                    }

                    PlayerWeaponView(baseSize: baseSize,
                                     yPosition: geometry.size.height - 80,
                                     playerAttackDirection: playerAttackDirection,
                                     isPlayerAttack: isPlayerAttack,
                                     playerAttackXPosition: playerAttackXPosition,
                                     playerPosition: playerPosition,
                                     attackDuration: playerAttackDuration)

                    PlayerView(playerPosition: playerPosition,
                               baseSize: baseSize,
                               yPosition: geometry.size.height - 65)
                }

                ActionBarView(playerPosition: $playerPosition,
                              baseSize: baseSize,
                              actionButtonText: actionButtonText,
                              actionButtonDisabled: isPlayerAttack || playerAttackDirection == .back) {
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
        actionButtonText = "WAIT"
        if isPlayerAttack || playerAttackDirection == .back { return }

        isPlayerAttack = true // Пропишем явно bool, чтобы не запутаться. Атака началась
        playerAttackDirection = .forward
        playerAttackXPosition = playerPosition

        // Состояние, когда сюрикен долетает до цели
        DispatchQueue.main.asyncAfter(deadline: .now() + playerAttackDuration) {
            playerAttackDirection = .back
            isPlayerAttack = false
            // 1.5 - это коэф от ширины сюрикена, чтобы засчитывалось попадание краем
            if playerAttackXPosition <= enemyPosition + halfSize * 1.5 &&
                playerAttackXPosition >= enemyPosition - halfSize * 1.5 {
                score += 1
                // Повышаем ставки))
                if score == 5 {
                    enemyAttackDuration = 0.8
                } else if score == 10 {
                    enemyAttackDuration = 0.6
                } else if score == 20 {
                    enemyAttackDuration = 0.4
                }
            }

            // Состояние, когда сюрикен возвращается обратно к игроку
            DispatchQueue.main.asyncAfter(deadline: .now() + playerAttackDuration) {
                playerAttackDirection = .forward
                actionButtonText = "ATTACK"
            }
        }


    }

    private func enemyAttack() {
        isEnemyAttack = true
        enemyAttackDirection = .forward
        // Определяем рандомную цель, куда бьет противник
        enemyAttackXPosition = Double.random(
            in: halfSize...UIScreen.main.bounds.width - halfSize
        )

        // Состояние, когда сюрикен долетает до цели
        DispatchQueue.main.asyncAfter(deadline: .now() + enemyAttackDuration) {
            enemyAttackDirection = .back
            isEnemyAttack = false
            if enemyAttackXPosition <= playerPosition + halfSize * 1.5 &&
                enemyAttackXPosition >= playerPosition - halfSize * 1.5 {
                health -= 1
                if health == 0 {
                    withAnimation {
                        page = .gameOver
                    }
                }
            }
            // Состояние, когда сюрикен возвращается обратно к противнику
            DispatchQueue.main.asyncAfter(deadline: .now() + enemyAttackDuration) {
                enemyAttackDirection = .forward
                self.enemyAttack()
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(page: .constant(.game), score: .constant(0))
    }
}

