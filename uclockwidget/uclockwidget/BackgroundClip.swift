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

//cropImage(lightUIImage!, toRect: postion.getRect())

func cropImage(
    _ inputImage: UIImage,
    toRect cropRect: CGRect,
    viewWidth: CGFloat = UIScreen.main.bounds.width,
    viewHeight: CGFloat = UIScreen.main.bounds.height
) -> UIImage? {
    let imageViewScale = max(inputImage.size.width / viewWidth,
                             inputImage.size.height / viewHeight)

    // Scale cropRect to handle images larger than shown-on-screen size
    let cropZone = CGRect(x: cropRect.origin.x * imageViewScale,
                          y: cropRect.origin.y * imageViewScale,
                          width: cropRect.size.width * imageViewScale,
                          height: cropRect.size.height * imageViewScale)

    // Perform cropping in Core Graphics
    guard let cutImageRef: CGImage = inputImage.cgImage?.cropping(to: cropZone)
    else {
        return nil
    }

    // Return image to UIImage
    let croppedImage = UIImage(cgImage: cutImageRef)
    return croppedImage
}

enum WidgetCropPostion: Int {
    case smallTopLeft
    case smallTopRight
    case smallCenterLeft
    case smallCenterRight
    case smallBottomLeft
    case smallBottomRight

    case mediumTop
    case mediumCenter
    case mediumBottom

    func getRect() -> CGRect {
        switch self {
        case .smallTopLeft:
            return CGRect(origin: DeviceWidgetPosition.smallTopLeft, size: DeviceWidgetSize.small)
        case .smallTopRight:
            return CGRect(origin: DeviceWidgetPosition.smallTopRight, size: DeviceWidgetSize.small)
        case .smallCenterLeft:
            return CGRect(origin: DeviceWidgetPosition.smallCenterLeft, size: DeviceWidgetSize.small)
        case .smallCenterRight:
            return CGRect(origin: DeviceWidgetPosition.smallCenterRight, size: DeviceWidgetSize.small)
        case .smallBottomLeft:
            return CGRect(origin: DeviceWidgetPosition.smallBottomLeft, size: DeviceWidgetSize.small)
        case .smallBottomRight:
            return CGRect(origin: DeviceWidgetPosition.smallBottomRight, size: DeviceWidgetSize.small)
        case .mediumTop:
            return CGRect(origin: DeviceWidgetPosition.mediumTop, size: DeviceWidgetSize.meduim)
        case .mediumCenter:
            return CGRect(origin: DeviceWidgetPosition.mediumCenter, size: DeviceWidgetSize.meduim)
        case .mediumBottom:
            return CGRect(origin: DeviceWidgetPosition.mediumBottom, size: DeviceWidgetSize.meduim)
        }
    }
}

// 小组件在屏幕上的位置
struct DeviceWidgetPosition {
    // 小组件 左上
    static var smallTopLeft: CGPoint {
        switch UIDevice().type {
        case .iPhone12ProMax:
            return CGPoint(x: 32, y: 82)
        case .iPhone12Pro, .iPhone12:
            return CGPoint(x: 26, y: 77)
        case .iPhone12Mini:
            return CGPoint(x: 23, y: 77)
        case .iPhone11ProMax, .iPhone11, .iPhoneXSMax, .iPhoneXR:
            return CGPoint(x: 27, y: 76)
        case .iPhone11Pro, .iPhoneXS, .iPhoneX:
            return CGPoint(x: 23, y: 71)
        case .iPhone6SPlus, .iPhone7Plus, .iPhone8Plus:
            return CGPoint(x: 33, y: 38)
        case .iPhone6S, .iPhone7, .iPhone8, .iPhoneSE2:
            return CGPoint(x: 28, y: 30)
        case .iPhoneSE, .iPod7:
            return CGPoint(x: 14, y: 30)
        default:
            return CGPoint(x: 27, y: 76)
        }
    }

    // 小组件 右上
    static var smallTopRight: CGPoint {
        switch UIDevice().type {
        case .iPhone12ProMax:
            return CGPoint(x: 226, y: 82)
        case .iPhone12Pro, .iPhone12:
            return CGPoint(x: 206, y: 77)
        case .iPhone12Mini:
            return CGPoint(x: 197, y: 77)
        case .iPhone11ProMax, .iPhone11, .iPhoneXSMax, .iPhoneXR:
            return CGPoint(x: 218, y: 76)
        case .iPhone11Pro, .iPhoneXS, .iPhoneX:
            return CGPoint(x: 197, y: 71)
        case .iPhone6SPlus, .iPhone7Plus, .iPhone8Plus:
            return CGPoint(x: 224, y: 38)
        case .iPhone6S, .iPhone7, .iPhone8, .iPhoneSE2:
            return CGPoint(x: 200, y: 30)
        case .iPhoneSE, .iPod7:
            return CGPoint(x: 165, y: 30)
        default:
            return CGPoint(x: 218, y: 76)
        }
    }

    // 小组件 中左
    static var smallCenterLeft: CGPoint {
        switch UIDevice().type {
        case .iPhone12ProMax:
            return CGPoint(x: 32, y: 294)
        case .iPhone12Pro, .iPhone12:
            return CGPoint(x: 26, y: 273)
        case .iPhone12Mini:
            return CGPoint(x: 23, y: 267)
        case .iPhone11ProMax, .iPhone11, .iPhoneXSMax, .iPhoneXR:
            return CGPoint(x: 27, y: 286)
        case .iPhone11Pro, .iPhoneXS, .iPhoneX:
            return CGPoint(x: 23, y: 261)
        case .iPhone6SPlus, .iPhone7Plus, .iPhone8Plus:
            return CGPoint(x: 33, y: 232)
        case .iPhone6S, .iPhone7, .iPhone8, .iPhoneSE2:
            return CGPoint(x: 27, y: 206)
        case .iPhoneSE, .iPod7:
            return CGPoint(x: 14, y: 200)
        default:
            return CGPoint(x: 218, y: 76)
        }
    }

    // 小组件 中右
    static var smallCenterRight: CGPoint {
        switch UIDevice().type {
        case .iPhone12ProMax:
            return CGPoint(x: 226, y: 294)
        case .iPhone12Pro, .iPhone12:
            return CGPoint(x: 206, y: 273)
        case .iPhone12Mini:
            return CGPoint(x: 197, y: 267)
        case .iPhone11ProMax, .iPhone11, .iPhoneXSMax, .iPhoneXR:
            return CGPoint(x: 218, y: 286)
        case .iPhone11Pro, .iPhoneXS, .iPhoneX:
            return CGPoint(x: 197, y: 261)
        case .iPhone6SPlus, .iPhone7Plus, .iPhone8Plus:
            return CGPoint(x: 224, y: 232)
        case .iPhone6S, .iPhone7, .iPhone8, .iPhoneSE2:
            return CGPoint(x: 200, y: 206)
        case .iPhoneSE, .iPod7:
            return CGPoint(x: 165, y: 200)
        default:
            return CGPoint(x: 218, y: 76)
        }
    }

    // 小组件 下左
    static var smallBottomLeft: CGPoint {
        switch UIDevice().type {
        case .iPhone12ProMax:
            return CGPoint(x: 32, y: 506)
        case .iPhone12Pro, .iPhone12:
            return CGPoint(x: 26, y: 469)
        case .iPhone12Mini:
            return CGPoint(x: 23, y: 457)
        case .iPhone11ProMax, .iPhone11, .iPhoneXSMax, .iPhoneXR:
            return CGPoint(x: 27, y: 495.3333)
        case .iPhone11Pro, .iPhoneXS, .iPhoneX:
            return CGPoint(x: 23, y: 451)
        case .iPhone6SPlus, .iPhone7Plus, .iPhone8Plus:
            return CGPoint(x: 33, y: 426)
        case .iPhone6S, .iPhone7, .iPhone8, .iPhoneSE2:
            return CGPoint(x: 27, y: 382)
        case .iPhoneSE, .iPod7:
            return CGPoint(x: 0, y: 0)
        default:
            return CGPoint(x: 218, y: 76)
        }
    }

    // 小组件 下右
    static var smallBottomRight: CGPoint {
        switch UIDevice().type {
        case .iPhone12ProMax:
            return CGPoint(x: 226, y: 506)
        case .iPhone12Pro, .iPhone12:
            return CGPoint(x: 206, y: 469)
        case .iPhone12Mini:
            return CGPoint(x: 197, y: 457)
        case .iPhone11ProMax, .iPhone11, .iPhoneXSMax, .iPhoneXR:
            return CGPoint(x: 218, y: 495.3333)
        case .iPhone11Pro, .iPhoneXS, .iPhoneX:
            return CGPoint(x: 197, y: 451)
        case .iPhone6SPlus, .iPhone7Plus, .iPhone8Plus:
            return CGPoint(x: 224, y: 426)
        case .iPhone6S, .iPhone7, .iPhone8, .iPhoneSE2:
            return CGPoint(x: 200, y: 382)
        case .iPhoneSE, .iPod7:
            return CGPoint(x: 0, y: 0)
        default:
            return CGPoint(x: 218, y: 76)
        }
    }

    // 中组件 上方
    static var mediumTop: CGPoint {
        switch UIDevice().type {
        case .iPhone12ProMax:
            return CGPoint(x: 32, y: 82)
        case .iPhone12Pro, .iPhone12:
            return CGPoint(x: 26, y: 77)
        case .iPhone12Mini:
            return CGPoint(x: 23, y: 77)
        case .iPhone11ProMax, .iPhone11, .iPhoneXSMax, .iPhoneXR:
            return CGPoint(x: 27, y: 76)
        case .iPhone11Pro, .iPhoneXS, .iPhoneX:
            return CGPoint(x: 23, y: 71)
        case .iPhone6SPlus, .iPhone7Plus, .iPhone8Plus:
            return CGPoint(x: 33, y: 38)
        case .iPhone6S, .iPhone7, .iPhone8, .iPhoneSE2:
            return CGPoint(x: 28, y: 30)
        case .iPhoneSE, .iPod7:
            return CGPoint(x: 14, y: 30)
        default:
            return CGPoint(x: 218, y: 76)
        }
    }

    // 中组件 中间
    static var mediumCenter: CGPoint {
        switch UIDevice().type {
        case .iPhone12ProMax:
            return CGPoint(x: 32, y: 294)
        case .iPhone12Pro, .iPhone12:
            return CGPoint(x: 26, y: 273)
        case .iPhone12Mini:
            return CGPoint(x: 23, y: 267)
        case .iPhone11ProMax, .iPhone11, .iPhoneXSMax, .iPhoneXR:
            return CGPoint(x: 27, y: 286)
        case .iPhone11Pro, .iPhoneXS, .iPhoneX:
            return CGPoint(x: 23, y: 261)
        case .iPhone6SPlus, .iPhone7Plus, .iPhone8Plus:
            return CGPoint(x: 33, y: 232)
        case .iPhone6S, .iPhone7, .iPhone8, .iPhoneSE2:
            return CGPoint(x: 27, y: 206)
        case .iPhoneSE, .iPod7:
            return CGPoint(x: 14, y: 200)
        default:
            return CGPoint(x: 218, y: 76)
        }
    }

    // 中组件 下方
    static var mediumBottom: CGPoint {
        switch UIDevice().type {
        case .iPhone12ProMax:
            return CGPoint(x: 32, y: 506)
        case .iPhone12Pro, .iPhone12:
            return CGPoint(x: 26, y: 469)
        case .iPhone12Mini:
            return CGPoint(x: 23, y: 457)
        case .iPhone11ProMax, .iPhone11, .iPhoneXSMax, .iPhoneXR:
            return CGPoint(x: 27, y: 495.3333)
        case .iPhone11Pro, .iPhoneXS, .iPhoneX:
            return CGPoint(x: 23, y: 451)
        case .iPhone6SPlus, .iPhone7Plus, .iPhone8Plus:
            return CGPoint(x: 33, y: 426)
        case .iPhone6S, .iPhone7, .iPhone8, .iPhoneSE2:
            return CGPoint(x: 27, y: 382)
        case .iPhoneSE, .iPod7:
            return CGPoint(x: 0, y: 0)
        default:
            return CGPoint(x: 218, y: 76)
        }
    }
}

// 小组件的大小
enum DeviceWidgetSize {
    static var small: CGSize {
        switch UIDevice().type {
        case .iPhone12ProMax:
            return CGSize(width: 170, height: 170)
        case .iPhone12Pro, .iPhone12:
            return CGSize(width: 158, height: 158)
        case .iPhone11ProMax, .iPhone11, .iPhoneXSMax, .iPhoneXR:
            return CGSize(width: 169, height: 169)
        case .iPhone12Mini, .iPhone11Pro, .iPhoneXS, .iPhoneX:
            return CGSize(width: 155, height: 155)
        case .iPhone6SPlus, .iPhone7Plus, .iPhone8Plus:
            return CGSize(width: 159, height: 159)
        case .iPhone6S, .iPhone7, .iPhone8, .iPhoneSE2:
            return CGSize(width: 148, height: 148)
        case .iPhoneSE, .iPod7:
            return CGSize(width: 141, height: 144)
        default:
            return CGSize(width: 169, height: 169)
        }
    }

    static var meduim: CGSize {
        switch UIDevice().type {
        case .iPhone12ProMax:
            return CGSize(width: 364, height: 170)
        case .iPhone12Pro, .iPhone12:
            return CGSize(width: 338, height: 158)
        case .iPhone11ProMax, .iPhone11, .iPhoneXSMax, .iPhoneXR:
            return CGSize(width: 360, height: 169)
        case .iPhone12Mini, .iPhone11Pro, .iPhoneXS, .iPhoneX:
            return CGSize(width: 329, height: 155)
        case .iPhone6SPlus, .iPhone7Plus, .iPhone8Plus:
            return CGSize(width: 348, height: 159)
        case .iPhone6S, .iPhone7, .iPhone8, .iPhoneSE2:
            return CGSize(width: 322, height: 148)
        case .iPhoneSE, .iPod7:
            return CGSize(width: 291, height: 144)
        default:
            return CGSize(width: 360, height: 169)
        }
    }
}

extension UIDevice {
    enum Model: String {
        // Simulator
        case simulator = "simulator/sandbox",

             // iPod
             iPod7 = "iPod 7",

             // iPhone
             iPhone6S = "iPhone 6S",
             iPhone6SPlus = "iPhone 6S Plus",
             iPhoneSE = "iPhone SE",
             iPhone7 = "iPhone 7",
             iPhone7Plus = "iPhone 7 Plus",
             iPhone8 = "iPhone 8",
             iPhone8Plus = "iPhone 8 Plus",
             iPhoneX = "iPhone X",
             iPhoneXS = "iPhone XS",
             iPhoneXSMax = "iPhone XS Max",
             iPhoneXR = "iPhone XR",
             iPhone11 = "iPhone 11",
             iPhone11Pro = "iPhone 11 Pro",
             iPhone11ProMax = "iPhone 11 Pro Max",
             iPhoneSE2 = "iPhone SE 2nd gen",
             iPhone12Mini = "iPhone 12 Mini",
             iPhone12 = "iPhone 12",
             iPhone12Pro = "iPhone 12 Pro",
             iPhone12ProMax = "iPhone 12 Pro Max",

             unrecognized = "?unrecognized?"
    }

    var type: Model {
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String(validatingUTF8: ptr)
            }
        }

        let modelMap: [String: Model] = [
            // Simulator
            "i386": .simulator,
            "x86_64": .simulator,

            // iPod
            "iPod9,1": .iPod7,

            // iPhone
            "iPhone8,1": .iPhone6S,
            "iPhone8,2": .iPhone6SPlus,
            "iPhone8,4": .iPhoneSE,
            "iPhone9,1": .iPhone7,
            "iPhone9,3": .iPhone7,
            "iPhone9,2": .iPhone7Plus,
            "iPhone9,4": .iPhone7Plus,
            "iPhone10,1": .iPhone8,
            "iPhone10,4": .iPhone8,
            "iPhone10,2": .iPhone8Plus,
            "iPhone10,5": .iPhone8Plus,
            "iPhone10,3": .iPhoneX,
            "iPhone10,6": .iPhoneX,
            "iPhone11,2": .iPhoneXS,
            "iPhone11,4": .iPhoneXSMax,
            "iPhone11,6": .iPhoneXSMax,
            "iPhone11,8": .iPhoneXR,
            "iPhone12,1": .iPhone11,
            "iPhone12,3": .iPhone11Pro,
            "iPhone12,5": .iPhone11ProMax,
            "iPhone12,8": .iPhoneSE2,
            "iPhone13,1": .iPhone12Mini,
            "iPhone13,2": .iPhone12,
            "iPhone13,3": .iPhone12Pro,
            "iPhone13,4": .iPhone12ProMax,
        ]

        if let model = modelMap[String(validatingUTF8: modelCode!)!] {
            if model == .simulator {
                if let simModelCode = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                    if let simModel = modelMap[String(validatingUTF8: simModelCode)!] {
                        return simModel
                    }
                }
            }
            return model
        }
        return Model.unrecognized
    }
}
