//
//  MoveButtonView.swift
//  NinjaBattle
//
//  Created by Anton Saltykov on 04.11.2022.
//

import SwiftUI

struct MoveButtonView: View {

    let text: String
    let action: () -> ()

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.custom("AmericanTypewriter",fixedSize: 36)).bold(true)
                .frame(width: 60, height: 60)
                .foregroundColor(.orange)
                .background(.white)
                .clipShape(Circle())
        }
    }
}

struct MoveButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.orange)
            MoveButtonView(text: "L") {
                //
            }
        }
    }
}
