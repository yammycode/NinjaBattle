//
//  ScoreBarView.swift
//  NinjaBattle
//
//  Created by Anton Saltykov on 04.11.2022.
//

import SwiftUI

struct ScoreBarView: View {

    var score: Int

    var body: some View {
        HStack {
            Text("Score: \(score)")
                .foregroundColor(.white)
                .font(.title)
                .bold()
            Spacer()
            Image(systemName: "heart.fill").foregroundColor(.white)
            Image(systemName: "heart.fill").foregroundColor(.white)
            Image(systemName: "heart.fill").foregroundColor(.white).opacity(0.4)
        }
        .padding(.horizontal)
        .frame(height: 50)
    }
}

struct ScoreBarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.orange)
            ScoreBarView(score: 10) 
        }
    }
}
