//
//  CloverShape.swift
//  PxClock
//
//  Created by leo on 2025.12.16.
//

//
//  CloverShape.swift
//  uclockwidget
//
//  Created by wyw on 2022/5/7.
//

import SwiftUI

struct CloverShape: Shape {
    func path(in rect: CGRect) -> Path {
        let squareWidth = min(rect.width, rect.height)
        let centerOffset = rect.size / 2
        let rInner = squareWidth * 0.39
        let rOuter = squareWidth * 0.61
        let rCtrl = squareWidth * 0.47
        let twoPi = CGFloat.pi * 2
        return Path {path in
            let angleOffset: CGFloat = 0.0
            path.move(to: CGPoint(angleRad: twoPi / 24 - angleOffset, r: rCtrl) + centerOffset)
            for i in 1...12 {
                let isInner = i % 3 == 0
                let currentAngle = twoPi / 12 * CGFloat(i)
                path.addQuadCurve(
                    to: CGPoint(
                        angleRad: twoPi / 24 + currentAngle
                        + (isInner ? -angleOffset : angleOffset),
                        r: isInner ? rCtrl : (i % 3 == 1 ? rOuter : rCtrl)
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

struct CloverShapePreview: PreviewProvider {
    static var previews: some View {
        CloverShape().fill()
            .frame(width: 300, height: 300)
            .border(Color.green, width: 2)
    }
}
