//
//  StartView.swift
//  NinjaBattle
//
//  Created by Anton Saltykov on 05.11.2022.
//

import SwiftUI

struct StartView: View {

    @Binding var page: Page

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.orange.gradient)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                ZStack {
                    NinjaView().frame(width: 100, height: 100)
                    WeaponView().frame(width: 50, height: 50)
                        .offset(x: -35, y: 50)
                }.padding(.bottom, 20)

                Text("Ninja Battle")
                    .font(.custom("AmericanTypewriter", fixedSize: 36)).bold(true)
                    .foregroundColor(.white)
                Text("Сразитесь с великим мастером-ниндзя Юай Кит. Метайте в противника сюрикены, но не забывайте уворачиваться от его атак. И помните: со времение Юай Кит становится все злее и быстрее.")
                    .multilineTextAlignment(.center)
                    .font(.custom("AmericanTypewriter", fixedSize: 20))
                ActionButtonView(actionButtonText: "НАЧАТЬ", actionButtonDisabled: false) {
                    withAnimation {
                        page = .game
                    }
                }
            }.padding(.horizontal)
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(page: .constant(.start))
    }
}
