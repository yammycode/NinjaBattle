//
//  NinjaView.swift
//  NinjaBattle
//
//  Created by Anton Saltykov on 04.11.2022.
//

import SwiftUI

struct NinjaView: View {
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height

            let size = min(width, height)

            Circle()
                .fill(.black)
                .frame(width: size, height: size)

            Path { path in
                path.move(to: CGPoint(x: 0, y: size / 3))

                path.addQuadCurve(
                    to: CGPoint(x: size , y: size / 3),
                    control: CGPoint(x: size / 2 , y: size / 3 + 10))

                path.addLine(to: CGPoint(x: size, y: size / 2))

                path.addQuadCurve(
                    to: CGPoint(x: 0, y: size / 2),
                    control: CGPoint(x: size / 2 , y: size / 2 + 40)
                )

            }
            .fill(Color(red: 250/255, green: 196/255, blue: 156/255))
            .clipShape(Circle())

            Path { path in
                path.move(to: CGPoint(x: 0, y: size * 0.8))

                path.addQuadCurve(
                    to: CGPoint(x: size, y: size * 0.8),
                    control: CGPoint(x: size / 2, y: size / 2 - size * 0.2)
                )
            }.clipShape(Circle())

            Path { path in
                path.move(to: CGPoint(x: 10, y: 40))

                path.addQuadCurve(
                    to: CGPoint(x: 40, y: 46),
                    control: CGPoint(x: 20, y: 40)
                )
                path.addQuadCurve(
                    to: CGPoint(x: 10, y: 40),
                    control: CGPoint(x: 20, y: 60)
                )
            }.fill(.black)


            Path { path in
                path.move(to: CGPoint(x: size - 10, y: 40))

                path.addQuadCurve(
                    to: CGPoint(x: size - 40, y: 46),
                    control: CGPoint(x: size - 20, y: 40)
                )
                path.addQuadCurve(
                    to: CGPoint(x: size - 10, y: 40),
                    control: CGPoint(x: size - 20, y: 60)
                )
            }.fill(.black)
        }
    }
}

struct NinjaView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .top) {
            Color(.orange)
            NinjaView()
                .frame(width: 100, height: 100)
        }

    }
}
