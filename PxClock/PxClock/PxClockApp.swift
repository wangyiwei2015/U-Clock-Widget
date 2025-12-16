//
//  PxClockApp.swift
//  PxClock
//
//  Created by leo on 2025.12.16.
//

import SwiftUI

@main
struct PxClockApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    try? FileManager.default.createDirectory(
                        at: URL(fileURLWithPath: imgPath),
                        withIntermediateDirectories: true
                    )
                }
        }
    }
}
