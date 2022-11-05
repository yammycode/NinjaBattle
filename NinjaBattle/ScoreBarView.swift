//
//  ScoreBarView.swift
//  NinjaBattle
//
//  Created by Anton Saltykov on 04.11.2022.
//

import SwiftUI

struct ScoreBarView: View {

    var score: Int
    var health: Int
    var totalHealth = 5

    var body: some View {
        HStack {
            Text("Score: \(score)")
                .foregroundColor(.white)
                .font(.custom("AmericanTypewriter",fixedSize: 36)).bold(true)
            Spacer()
            ForEach(1...totalHealth, id: \.self) {index in
                Image(systemName: "heart.fill")
                    .foregroundColor(.white)
                    .opacity(index <= health ? 1 : 0.4)
            }

        }
        .padding(.horizontal)
        .frame(height: 50)
    }
}

struct ScoreBarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.orange)
            ScoreBarView(score: 10, health: 3)
        }
    }
}
