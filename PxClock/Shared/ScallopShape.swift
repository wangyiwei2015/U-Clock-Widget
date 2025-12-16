//
//  ScallopShape.swift
//  PxClock
//
//  Created by leo on 2025.12.16.
//

//
//  ScallopClockShape.swift
//  uclockwidget
//
//  Created by wyw on 2022/3/30.
//

import SwiftUI

struct ScallopShape: Shape {
    func path(in rect: CGRect) -> Path {
        let squareWidth = min(rect.width, rect.height)
        let centerOffset = rect.size / 2
        let rInner = squareWidth * 0.46 //0.43
        let rOuter = squareWidth * 0.53 //0.47
        let rCtrl = squareWidth * 0.49
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

struct ScallopShapePreview: PreviewProvider {
    static var previews: some View {
        ScallopShape().fill()
            .frame(width: 300, height: 300)
            .border(Color.green, width: 2)
    }
}
