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

enum EnemyDirection {
    case right, left
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
    @State private var isPlayerDone = false

    @State private var isEnemyAttack = false
    @State private var enemyAttackDirection: WeaponDirection = .forward
    @State private var enemyAttackXPosition = 0.0
    @State private var enemyDirection = EnemyDirection.right
    @State private var isEnemyDone = false

    @State private var actionButtonText = "ATTACK"

    private var halfSize: Double {
        baseSize / 2
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.orange.gradient)
                .ignoresSafeArea()
            ZStack {

                MessageView(isMessage: isEnemyDone)

                VStack(alignment: .leading) {
                    ScoreBarView(score: score, health: health)

                    GeometryReader {geometry in

                        // Enemy
                        NinjaView(color: isEnemyDone ? .red : Color(red: 28/255, green:  4/255, blue: 145/255))
                            .frame(width: baseSize, height: baseSize)
                            .position(x: enemyPosition, y: 50)
                            .animation(.default, value: enemyPosition)
                            .onAppear {
                                setEnemyPosition()
                            }

                        // Enemy weapon
                        WeaponView()
                            .frame(width: halfSize, height: halfSize)
                            .position(
                                x: isEnemyAttack ? enemyAttackXPosition : enemyPosition,
                                y: isEnemyAttack ? geometry.size.height - 80 : 100
                            )
                            .animation(
                                Animation.linear(duration: enemyAttackDuration),
                                value: isEnemyAttack
                            )
                            .animation(.default, value: enemyPosition)
                            .opacity(enemyAttackDirection == .forward && isEnemyAttack ? 1 : 0)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                    enemyAttack()
                                }
                            }

                        // Player weapon
                        WeaponView()
                            .frame(width: baseSize / 2, height: baseSize / 2)
                            .position(
                                x: playerAttackDirection == .forward && isPlayerAttack
                                ? playerAttackXPosition
                                : playerPosition,
                                y: isPlayerAttack ? 110 : geometry.size.height - 80
                            )
                            .animation(.default, value: playerPosition)
                            .animation(
                                Animation.linear(duration: playerAttackDuration),
                                value: isPlayerAttack
                            )
                            .opacity(playerAttackDirection == .forward && isPlayerAttack ? 1 : 0)

                        // Player
                        NinjaView(color: isPlayerDone ? .red : .black)
                            .frame(width: baseSize, height: baseSize)
                            .position(x: playerPosition, y: geometry.size.height - 65)
                            .animation(.default, value: playerPosition)
                            .onAppear {
                                initPlayerPosition()
                            }
                    }

                    ActionBarView(playerPosition: $playerPosition,
                                  baseSize: baseSize,
                                  actionButtonText: actionButtonText,
                                  actionButtonDisabled: isPlayerAttack || playerAttackDirection == .back) {
                        playerAttack()
                    }
                }
            }
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
                withAnimation(
                    Animation.easeInOut(duration: 0.1).repeatCount(3)
                ) {
                    isEnemyDone.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        isEnemyDone.toggle()
                    }
                }
                // Повышаем градус))
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
                withAnimation(
                    Animation.easeInOut(duration: 0.1).repeatCount(3)
                ) {
                    isPlayerDone.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        isPlayerDone.toggle()
                    }
                }
                // Game over
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

    private func setEnemyPosition() {

        // Придется тут немного нагородить костылей,
        // чтобы была возможность отследить положение противника когда сюрикен достигнет цели
        // И определить, было ли попадание

        let stepsByClick = 10.0

        if enemyPosition <= baseSize / 2 {
            enemyDirection = .right
        } else if enemyPosition >= UIScreen.main.bounds.width - baseSize / 2 {
            enemyDirection = .left
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            if enemyDirection == .right {
                enemyPosition += stepsByClick
            } else {
                enemyPosition -= stepsByClick
            }
            setEnemyPosition()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(page: .constant(.game), score: .constant(0))
    }
}

