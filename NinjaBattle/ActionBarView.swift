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
    var attacAction: () -> ()

    private let moveStepValue = 50.0

    var body: some View {
        HStack {
            MoveButtonView(text: "left", action: moveLeft)
            Spacer()
            Button {
                attacAction()
            } label: {
                Text("Attack")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding(EdgeInsets(top: 7, leading: 25, bottom: 7, trailing: 25))
                    .background(.white)
                    .cornerRadius(40)
                    .foregroundColor(.orange)
                    .padding(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(.white, lineWidth: 5)
                    )
            }
            Spacer()

            MoveButtonView(text: "Right", action: moveRight)
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
            ActionBarView(playerPosition: .constant(0), baseSize: 100) {
                //
            }
        }
    }
}
