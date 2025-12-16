//
//  PxClockWidgetBundle.swift
//  PxClockWidget
//
//  Created by leo on 2025.12.16.
//

import WidgetKit
import SwiftUI

@main
struct PxClockWidgetBundle: WidgetBundle {
    var body: some Widget {
        microClkWidget()
        UCWG_Scallop()
        UCWG_Circle()
        UCWG_Clover()
        if #available(iOS 18.0, *) {
            PxClockWidgetControl()
        }
    }
}
