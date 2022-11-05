//
//  PlayerView.swift
//  NinjaBattle
//
//  Created by Anton Saltykov on 05.11.2022.
//

import SwiftUI

struct PlayerView: View {

    var playerPosition: Double
    var baseSize: Double
    var yPosition: Double

    var body: some View {
        NinjaView()
            .frame(width: baseSize, height: baseSize)
            .position(x: playerPosition, y: yPosition)
            .animation(.default, value: playerPosition)
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(playerPosition: 50, baseSize: 100, yPosition: 50)
    }
}
