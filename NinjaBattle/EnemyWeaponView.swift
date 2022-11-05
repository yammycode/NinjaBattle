//
//  EnemyWeaponView.swift
//  NinjaBattle
//
//  Created by Anton Saltykov on 05.11.2022.
//

import SwiftUI

struct EnemyWeaponView: View {

    var size: Double
    var isEnemyAttack: Bool
    var enemyAttackXPosition: Double
    var enemyPosition: Double
    var yPosition: Double
    var attackDuration: Double
    var enemyAttackDirection: WeaponDirection
    var action: () -> ()

    var body: some View {
        WeaponView()
            .frame(width: size, height: size)
            .position(
                x: isEnemyAttack ? enemyAttackXPosition : enemyPosition,
                y: isEnemyAttack ? yPosition : 100
            )

            .animation(
                Animation.linear(duration: attackDuration),
                value: isEnemyAttack
            )
            .animation(.default, value: enemyPosition)
            .opacity(enemyAttackDirection == .forward && isEnemyAttack ? 1 : 0)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    action()
                }
            }
    }
}

struct EnemyWeaponView_Previews: PreviewProvider {
    static var previews: some View {
        EnemyWeaponView(size: 50,
                        isEnemyAttack: true,
                        enemyAttackXPosition: 100,
                        enemyPosition: 100,
                        yPosition: 100,
                        attackDuration: 50,
                        enemyAttackDirection: .forward) {
            //
        }
    }
}
