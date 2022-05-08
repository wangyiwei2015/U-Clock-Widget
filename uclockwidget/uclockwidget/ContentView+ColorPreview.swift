//
//  ContentView+ColorPreview.swift
//  uclockwidget
//
//  Created by wyw on 2022/5/8.
//

import SwiftUI

extension ContentView {
    @ViewBuilder var ColorPreviews: some View {
        HStack {
            Circle().fill().foregroundColor(firstColorLight)
                .frame(width: 30, height: 30)
            Circle().fill().foregroundColor(secondColorLight)
                .frame(width: 30, height: 30)
//            Color.white
//                .overlay(mainColorLight.opacity(0.8)
//                ).mask(Circle()
//                ).frame(width: 30, height: 30)
            Circle().fill().foregroundColor(firstColorLight)
                .opacity(0.3)
                .frame(width: 30, height: 30)
            
            Divider().padding(.horizontal)
            
            Circle().fill().foregroundColor(firstColorDark)
                .frame(width: 30, height: 30)
            Circle().fill().foregroundColor(secondColorDark)
                .frame(width: 30, height: 30)
//            Color.white
//                .overlay(mainColorDark.opacity(0.8)
//                ).mask(Circle()
//                ).frame(width: 30, height: 30)
            Circle().fill().foregroundColor(firstColorDark)
                .opacity(0.3)
                .frame(width: 30, height: 30)
        }
    }
}
