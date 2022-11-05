//
//  PlayerWeaponView.swift
//  NinjaBattle
//
//  Created by Anton Saltykov on 05.11.2022.
//

import SwiftUI

struct PlayerWeaponView: View {

    var baseSize: Double
    var yPosition: Double
    var playerAttackDirection: WeaponDirection
    var isPlayerAttack: Bool
    var playerAttackXPosition: Double
    var playerPosition: Double
    var attackDuration: Double

    var body: some View {
        WeaponView()
            .frame(width: baseSize / 2, height: baseSize / 2)
            .position(
                x: playerAttackDirection == .forward && isPlayerAttack
                ? playerAttackXPosition
                : playerPosition,
                y: isPlayerAttack ? 110 : yPosition
            )
            .animation(.default, value: playerPosition)
            .animation(
                Animation.linear(duration: attackDuration),
                value: isPlayerAttack
            )
            .opacity(playerAttackDirection == .forward && isPlayerAttack ? 1 : 0)
    }
}

struct PlayerWeaponView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerWeaponView(baseSize: 100,
                         yPosition: 100,
                         playerAttackDirection: .forward,
                         isPlayerAttack: true,
                         playerAttackXPosition: 100,
                         playerPosition: 100,
                         attackDuration: 0.6)
    }
}
