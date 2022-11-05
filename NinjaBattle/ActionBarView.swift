//
//  ActionBarView.swift
//  NinjaBattle
//
//  Created by Anton Saltykov on 04.11.2022.
//

import SwiftUI

struct ActionBarView: View {

    @Binding var playerPosition: Double
    var baseSize: Double
    var actionButtonText: String
    var actionButtonDisabled: Bool
    var attacAction: () -> ()

    private let moveStepValue = 50.0

    var body: some View {
        HStack {
            MoveButtonView(text: "L", action: moveLeft)
            Spacer()
            ActionButtonView(actionButtonText: actionButtonText,
                             actionButtonDisabled: actionButtonDisabled) {
                attacAction()
            }
            Spacer()
            MoveButtonView(text: "R", action: moveRight)
        }
        .padding(.horizontal)
        .frame(height: 50)
    }
}

extension ActionBarView {
    private func moveLeft() {
        if playerPosition - baseSize / 2 > moveStepValue {
            playerPosition -= moveStepValue
        } else {
            playerPosition = baseSize / 2
        }
    }

    private func moveRight() {
        if playerPosition + moveStepValue > UIScreen.main.bounds.width - baseSize / 2 {
            playerPosition = UIScreen.main.bounds.width - baseSize / 2
        } else {
            playerPosition += moveStepValue
        }
    }
}

struct ActionBarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.orange)
            ActionBarView(playerPosition: .constant(0),
                          baseSize: 100,
                          actionButtonText: "ATTACK",
                          actionButtonDisabled: false) {
                //
            }
        }
    }
}
