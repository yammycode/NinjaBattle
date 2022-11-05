//
//  WeaponView.swift
//  NinjaBattle
//
//  Created by Anton Saltykov on 04.11.2022.
//

import SwiftUI

struct WeaponView: View {

    @State private var isRotating = 0.0

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height

            ZStack {
                ForEach(0..<3) { iteration in
                    ZStack {
                        Rectangle()
                            .fill(
                                RadialGradient(
                                    gradient: Gradient(colors: [.orange, .white]),
                                    center: .center,
                                    startRadius: width * 0.02,
                                    endRadius: width * 0.5
                                )
                            )
                            .rotationEffect(.degrees(Double(iteration) * 60))
                            .frame(
                                width: width * 0.7,
                                height: height * 0.7
                            )
                    }

                }
                Circle()
                    .frame(width: width / 3, height: height / 3)
                    .blendMode(.destinationOut)

            }
            .compositingGroup()
            .rotationEffect(.degrees(isRotating))
            .onAppear {
                withAnimation(.linear(duration: 1)
                    .speed(0.7).repeatForever(autoreverses: false)) {
                    isRotating = 360.0
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }

        
    }
}

struct WeaponView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.orange)
            WeaponView()
                .frame(width: 100, height: 100)
        }

    }
}
