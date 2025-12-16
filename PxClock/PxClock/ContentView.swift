//
//  ContentView.swift
//  PxClock
//
//  Created by leo on 2025.12.16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            MiniClockView().overlay {
                NavigationLink("widget config") {
                    UClockMainView()
                }
            }
        }
    }
}

#Preview { ContentView() }
