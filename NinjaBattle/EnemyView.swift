//
//  EnemyView.swift
//  NinjaBattle
//
//  Created by Anton Saltykov on 05.11.2022.
//

import SwiftUI

enum EnemyDirection {
    case right, left
}

struct EnemyView: View {

    @State private var enemyDirection = EnemyDirection.right
    @Binding var enemyPosition: Double
    var baseSize: Double

    var body: some View {
        NinjaView()
            .frame(width: baseSize, height: baseSize)
            .frame(width: baseSize, height: baseSize)
            .position(x: enemyPosition, y: 50)
            .animation(.default, value: enemyPosition)
            .onAppear {
                setEnemyPosition()
            }
    }
}

extension EnemyView {
    private func setEnemyPosition() {

        // Придется тут немного нагородить костылей,
        // чтобы была возможность отследить положение противника когда сюрикен достигнет цели
        // И определить, было ли попадание
        if enemyPosition <= baseSize / 2 {
            enemyDirection = .right
        } else if enemyPosition >= UIScreen.main.bounds.width - baseSize / 2 {
            enemyDirection = .left
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            if enemyDirection == .right {
                enemyPosition += 10
            } else {
                enemyPosition -= 10
            }
            setEnemyPosition()
        }
    }
}

struct EnemyView_Previews: PreviewProvider {
    static var previews: some View {
        EnemyView(enemyPosition: .constant(100), baseSize: 100)
    }
}
