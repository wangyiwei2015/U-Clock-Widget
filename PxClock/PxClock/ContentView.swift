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
            Color.clear.overlay {
                MiniClockView()
            }.overlay(alignment: .topLeading) {
                NavigationLink {
                    UClockMainView()
                } label: {
                    Image(systemName: "gear")
                }.tint(.gray).font(.title2).padding(.leading).padding(.top, 10)
            }
        }
    }
}

#Preview { ContentView() }
