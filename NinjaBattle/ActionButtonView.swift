//
//  ActionButtonView.swift
//  NinjaBattle
//
//  Created by Anton Saltykov on 05.11.2022.
//

import SwiftUI

struct ActionButtonView: View {

    var actionButtonText:  String
    var actionButtonDisabled: Bool
    var action: () -> ()

    var body: some View {
        Button {
            action()
        } label: {
            Text(actionButtonText)
                .frame(width: 120)
                .font(.custom("AmericanTypewriter", fixedSize: 24)).bold(true)
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
        .disabled(actionButtonDisabled)
    }
}

struct ActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.orange)
            ActionButtonView(actionButtonText: "Button", actionButtonDisabled: false) {
        }
            //
        }
    }
}
