//
//  ContentViewComponents.swift
//  uclockwidget
//
//  Created by wyw on 2022/5/7.
//

import SwiftUI

extension ContentView {
    @ViewBuilder func AutoPlusSymbol(for object: UIImage?) -> some View {
        if object == nil {
            VStack {
                Image(systemName: "plus.circle")
                    .font(.system(size: 40, weight: .regular, design: .monospaced))
                    .foregroundColor(.gray)
                Text("Wallpaper")
                    .foregroundColor(.gray)
                    .padding(.top, 5)
            }
        } else {Spacer()}
    }
    
    @ViewBuilder var LightModeWallpaper: some View {
        Image(uiImage: bgBright ?? UIImage())
            .resizable()
            .aspectRatio(UIScreen.main.bounds.width / UIScreen.main.bounds.height, contentMode: .fit)
            .overlay(AutoPlusSymbol(for: bgBright))
            .background(Color(white: 0.9))
            .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .onTapGesture {
                isPickingLight = true
                setWallpaper()
            }.padding()
    }
    
    @ViewBuilder var DarkModeWallpaper: some View {
        Image(uiImage: bgDark ?? UIImage())
            .resizable()
            .aspectRatio(UIScreen.main.bounds.width / UIScreen.main.bounds.height, contentMode: .fit)
            .overlay(AutoPlusSymbol(for: bgDark))
            .background(Color(white: 0.3))
            .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .onTapGesture {
                isPickingLight = false
                setWallpaper()
            }.padding()
    }
    
    @ViewBuilder var SmallShpaeIcons: some View {
        HStack(spacing: 5) {
            Image(systemName: "seal")
            Image(systemName: "circle")
            Image(systemName: "fanblades")
            Spacer()
        }
        .font(.system(size: 16, weight: .black))
        .foregroundColor(Color(UIColor.systemGray4))
        .padding(10)
    }
}
