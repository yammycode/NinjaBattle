//
//  MessageView.swift
//  NinjaBattle
//
//  Created by Anton Saltykov on 06.11.2022.
//

import SwiftUI

struct MessageView: View {

    var isMessage: Bool

    var body: some View {
        Text("WOW")
            .font(.custom("GillSans", fixedSize: 70)).bold(true)
            .foregroundColor(.white)
            .opacity(isMessage ? 0.4 : 0)
            .scaleEffect(isMessage ? 1 : 2.5, anchor: .center)
            .animation(.easeIn(duration: 2), value: isMessage)

    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.orange)
            MessageView(isMessage: true)
        }

    }
}
