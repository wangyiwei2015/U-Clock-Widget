//
//  FlowerClockShape.swift
//  uclockwidget
//
//  Created by wyw on 2022/3/30.
//

import SwiftUI

struct FlowerClockShape: Shape {
    func path(in rect: CGRect) -> Path {
        let squareWidth = min(rect.width, rect.height)
        let centerOffset = rect.size / 2
        let rInner = squareWidth * 0.41 //0.43
        let rOuter = squareWidth * 0.49 //0.47
        let rCtrl = squareWidth * 0.45
        let twoPi = CGFloat.pi * 2
        return Path {path in
            path.move(to: CGPoint(angleRad: twoPi / 48, r: rCtrl) + centerOffset)
            for i in 1...24 {
                let isInner = i % 2 == 0
                let currentAngle = twoPi / 24 * CGFloat(i)
                path.addQuadCurve(
                    to: CGPoint(
                        angleRad: twoPi / 48 + currentAngle,
                        r: rCtrl
                    ) + centerOffset,
                    control: CGPoint(
                        angleRad: currentAngle,
                        r: isInner ? rInner : rOuter
                    ) + centerOffset
                )
            }
        }
    }
}

struct FlowerClockShape_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            FlowerClockShape().fill().foregroundColor(.gray)
        }
    }
}
