//
//  BackgroundClip.swift
//  uclockwidget
//
//  Created by wyw on 2022/3/31.
//

import SwiftUI

struct SpringboardGeometry {
    let name: String
    let size: CGSize
    let inset: EdgeInsets
    let verticalSpacing: CGFloat
    let widgetHeight: CGFloat
}

let screenProperties: [SpringboardGeometry] = [
    .init(
        name: "iPhone Pro Max",
        size: CGSize(width: 1284, height: 2778),
        inset: EdgeInsets(top: 246, leading: 105, bottom: 708, trailing: 105),
        verticalSpacing: 126,
        widgetHeight: 510
    ),
    .init(
        name: "iPhone & Pro",
        size: CGSize(width: 1170, height: 2532),
        inset: EdgeInsets(top: 231, leading: 78, bottom: -1, trailing: 78),
        verticalSpacing: 114,
        widgetHeight: 474
    ),
    .init(
        name: "iPhone mini",
        size: CGSize(width: 1080, height: 2340),
        inset: EdgeInsets(top: 222, leading: 66, bottom: -1, trailing: 66),
        verticalSpacing: 101,
        widgetHeight: 446.5
    ),
    //iPhone X and X max ?
    .init(
        name: "iPhone 4.7",
        size: CGSize(width: 750, height: 1334),
        inset: EdgeInsets(top: 60, leading: 54, bottom: -1, trailing: 54),
        verticalSpacing: 56,
        widgetHeight: 296
    ),
]
