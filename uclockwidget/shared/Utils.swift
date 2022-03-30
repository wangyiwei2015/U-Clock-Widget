//
//  Utils.swift
//  uclockwidget
//
//  Created by wyw on 2022/3/30.
//

import SwiftUI

extension CGPoint {
    init(angleRad: CGFloat, r: CGFloat) {
        self.init(x: r * cos(angleRad), y: r * sin(angleRad))
    }
}

func /<T: BinaryInteger>(lhs: CGSize, rhs: T) -> CGSize {
    CGSize(width: lhs.width / CGFloat(rhs), height: lhs.width / CGFloat(rhs))
}

func /<T: BinaryFloatingPoint>(lhs: CGSize, rhs: T) -> CGSize {
    CGSize(width: lhs.width / CGFloat(rhs), height: lhs.width / CGFloat(rhs))
}

func +(lhs: CGPoint, rhs: CGSize) -> CGPoint {
    CGPoint(x: lhs.x + rhs.width, y: lhs.y + rhs.height)
}
