//
//  ContentView+Crop.swift
//  uclockwidget
//
//  Created by wyw on 2022/5/8.
//

import SwiftUI
import ColorThiefSwift
import WidgetKit

extension ContentView {
    func updateWallpaperSave() {
        if isPickingLight {
            // Save light wallpaper -----------------------------------------------------------
            if let brightImg = bgBright {
                //full wallpaper
                try! brightImg.jpegData(compressionQuality: 1.0)?.write(to: URL(fileURLWithPath: "\(imgPath)/imgB.jpg"), options: .atomic)
                //theme color
                let theme = ColorThief.getPalette(from: brightImg, colorCount: 2)!
                var hue: CGFloat = 0
                var sat: CGFloat = 0
                var bri: CGFloat = 0
                let firstColor = theme[0].makeUIColor()
                firstColor.getHue(&hue, saturation: &sat, brightness: &bri, alpha: nil)
                ud.set([hue, sat, bri], forKey: "_IMG_COLOR_LIGHT_1")
                firstColorLight = Color(firstColor)
                let secondColor = theme[1].makeUIColor()
                secondColor.getHue(&hue, saturation: &sat, brightness: &bri, alpha: nil)
                ud.set([hue, sat, bri], forKey: "_IMG_COLOR_LIGHT_2")
                secondColorLight = Color(secondColor)
                //cropped wallpaper
                for pos in 1...9 {
                    if let img = cropImage(brightImg, toRect: WidgetCropPostion(rawValue: pos - 1)!.getRect()) {
                        try! img.jpegData(compressionQuality: 1.0)!.write(to: URL(fileURLWithPath: "\(imgPath)/imgB\(pos).jpg"), options: .atomic)
                    } else {
                        //error and cleanup
                        try? FileManager.default.removeItem(atPath: "\(imgPath)/imgB.jpg")
                        bgBright = nil
                        firstColorLight = .gray
                        secondColorLight = .gray
                        errAlert = true
                        return
                    }
                }
            }
            
        } else {
            // Save dark wallpaper -----------------------------------------------------------
            if let darkImg = bgDark {
                //full wallpaper
                try! darkImg.jpegData(compressionQuality: 1.0)?.write(to: URL(fileURLWithPath: "\(imgPath)/imgD.jpg"), options: .atomic)
                //theme color
                let theme = ColorThief.getPalette(from: darkImg, colorCount: 2)!
                var hue: CGFloat = 0
                var sat: CGFloat = 0
                var bri: CGFloat = 0
                let firstColor = theme[0].makeUIColor()
                firstColor.getHue(&hue, saturation: &sat, brightness: &bri, alpha: nil)
                ud.set([hue, sat, bri], forKey: "_IMG_COLOR_DARK_1")
                firstColorDark = Color(firstColor)
                let secondColor = theme[1].makeUIColor()
                secondColor.getHue(&hue, saturation: &sat, brightness: &bri, alpha: nil)
                ud.set([hue, sat, bri], forKey: "_IMG_COLOR_DARK_2")
                secondColorDark = Color(secondColor)
                //cropped wallpaper
                for pos in 1...9 {
                    if let img = cropImage(darkImg, toRect: WidgetCropPostion(rawValue: pos - 1)!.getRect()) {
                        try! img.jpegData(compressionQuality: 1.0)!.write(to: URL(fileURLWithPath: "\(imgPath)/imgD\(pos).jpg"), options: .atomic)
                    } else {
                        //error and cleanup
                        try? FileManager.default.removeItem(atPath: "\(imgPath)/imgD.jpg")
                        bgDark = nil
                        firstColorDark = .gray
                        secondColorDark = .gray
                        errAlert = true
                        return
                    }
                }
            }
            
        }
        //print(imgPath)
        postSaveWall()
    }
    
    func postSaveWall() {
        WidgetCenter.shared.reloadAllTimelines()
    }
}
