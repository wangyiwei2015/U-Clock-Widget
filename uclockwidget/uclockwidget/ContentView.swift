//
//  ContentView.swift
//  uclockwidget
//
//  Created by wyw on 2022/3/30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            FlowerClockView(
                dateFormat: "EE dd",
                fingerColorHue: 0.8,
                showSeconds: true,
                showNumbers: true,
                shape: .flower,
                hor: 10, mnt: 35, sec: 20
            )//.frame(width: 300, height: 200)
            .background(Color.gray)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
