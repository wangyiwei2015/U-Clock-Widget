//
//  uclockwidgetApp.swift
//  uclockwidget
//
//  Created by wyw on 2022/3/30.
//

import SwiftUI

@main
struct uclockwidgetApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    try? FileManager.default.createDirectory(at: URL(fileURLWithPath: imgPath), withIntermediateDirectories: true)
                }
        }
    }
}
