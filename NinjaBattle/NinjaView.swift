//
//  NinjaView.swift
//  NinjaBattle
//
//  Created by Anton Saltykov on 04.11.2022.
//

import SwiftUI

struct NinjaView: View {

    var color: Color

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height

            let size = min(width, height)

            // Завязки
            Path { path in
                path.move(to: CGPoint(x: size / 5, y: size / 10 + 5))
                path.addLine(to: CGPoint(x: size / 5, y: size / 5 + 5))
                path.addLine(to: CGPoint(x: 0, y: size / 10 + 2))
                path.addLine(to: CGPoint(x: 2, y: 0))
            }.fill(color)
            Path { path in
                path.move(to: CGPoint(x: size / 5, y: 0))
                path.addLine(to: CGPoint(x: size / 5 + 5, y: size / 10 + 5))
                path.addLine(to: CGPoint(x: size / 10 + 5, y: size / 10 + 5))
                path.addLine(to: CGPoint(x: size / 10 + 5, y: 2))
            }.fill(color)

            Circle()
                .fill(color)
                .frame(width: size, height: size)

            Path { path in
                path.move(to: CGPoint(x: 0, y: size / 3))

                path.addQuadCurve(
                    to: CGPoint(x: size , y: size / 3),
                    control: CGPoint(x: size / 2 , y: size / 3 + 10))

                path.addQuadCurve(to: CGPoint(x: size - 25, y: size / 2 + 10),
                                  control: CGPoint(x: size, y: size / 2 + 15))

                path.addQuadCurve(to: CGPoint(x: size - size * 0.75 , y: size / 2 + 10),
                                  control: CGPoint(x: size / 2, y: size / 2))

                path.addQuadCurve(to: CGPoint(x: 0, y: size / 3),
                                  control: CGPoint(x: 0, y: size / 2 + 15))

            }
            .fill(Color(red: 250/255, green: 196/255, blue: 156/255))
            .clipShape(Circle())

            // Левый глаз
            Path { path in
                path.move(to: CGPoint(x: size * 0.1, y: size * 0.4))

                path.addQuadCurve(
                    to: CGPoint(x: size * 0.4, y: size * 0.46),
                    control: CGPoint(x: size * 0.2, y: size * 0.4)
                )
                path.addQuadCurve(
                    to: CGPoint(x: size * 0.1, y: size * 0.4),
                    control: CGPoint(x: size * 0.2, y: size * 0.6)
                )
            }.fill(color)

            // Правый глаз
            Path { path in
                path.move(to: CGPoint(x: size - 10, y: size * 0.4))

                path.addQuadCurve(
                    to: CGPoint(x: size * 0.6, y: size * 0.46),
                    control: CGPoint(x: size * 0.8, y: size * 0.4)
                )
                path.addQuadCurve(
                    to: CGPoint(x: size * 0.9, y: size * 0.4),
                    control: CGPoint(x: size * 0.8, y: size * 0.6)
                )
            }.fill(color)

            // Рефлекс
            Path { path in
                path.move(to: CGPoint(x: 5, y: size * 0.35))

                path.addQuadCurve(to: CGPoint(x: size / 2, y: 0),
                                  control: CGPoint(x: size * 0.1, y: 8))
                path.addQuadCurve(to: CGPoint(x: size * 0.2, y: size * 0.36),
                                  control: CGPoint(x: size * 0.2, y: size * 0.2))

            }
            .fill(.white)
            .opacity(0.2)


        }
    }
}

struct NinjaView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.orange)
            NinjaView(color: Color(red: 28/255, green:  4/255, blue: 145/255))
                .frame(width: 100, height: 100)
        }

    }
}
