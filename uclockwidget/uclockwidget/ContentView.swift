//
//  ContentView.swift
//  uclockwidget
//
//  Created by wyw on 2022/3/30.
//

import SwiftUI

struct ContentView: View {
    @State var hor: Int = 0
    
    @State var bgBright: UIImage? = try? UIImage(data: Data(contentsOf: URL(fileURLWithPath: "\(imgPath)/imgB.jpg")))
    @State var bgDark: UIImage? = try? UIImage(data: Data(contentsOf: URL(fileURLWithPath: "\(imgPath)/imgD.jpg")))
    
    @State var isPickingLight = true
    @State var showsPicker = false
    @State var showsHelp = false
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var firstColorLight: Color = {
        if let savedColor = ud.object(forKey: "_IMG_COLOR_LIGHT_1")
            as? [CGFloat] {
            return Color(hue: savedColor[0], saturation: savedColor[1], brightness: savedColor[2])
        } else {return .gray}
    }()
    @State var secondColorLight: Color = {
        if let savedColor = ud.object(forKey: "_IMG_COLOR_LIGHT_2")
            as? [CGFloat] {
            return Color(hue: savedColor[0], saturation: savedColor[1], brightness: savedColor[2])
        } else {return .gray}
    }()
    @State var firstColorDark: Color = {
        if let savedColor = ud.object(forKey: "_IMG_COLOR_DARK_1")
            as? [CGFloat] {
            return Color(hue: savedColor[0], saturation: savedColor[1], brightness: savedColor[2])
        } else {return .gray}
    }()
    @State var secondColorDark: Color = {
        if let savedColor = ud.object(forKey: "_IMG_COLOR_DARK_2")
            as? [CGFloat] {
            return Color(hue: savedColor[0], saturation: savedColor[1], brightness: savedColor[2])
        } else {return .gray}
    }()
    
    var body: some View {
        VStack {
            //Title
            HStack {
                Text("UClock Widgets")
                    .font(.system(size: 24, weight: .semibold))
                Spacer()
                Button {
                    showsHelp = true
                } label: {
                    Image(systemName: "info.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.gray)
                }
            }.padding(.horizontal)
            
            //Clock
            ZStack {
                UClockView(
                    dateFormat: "EE dd",
                    date: Date(),
                    firstColor: colorScheme == .light ? firstColorLight : firstColorDark,
                    secondColor: colorScheme == .light ? secondColorLight : secondColorDark,
                    showSeconds: false,
                    showNumbers: true,
                    shape: .scallop, bordered: false,
                    hor: 10, mnt: 8, sec: 30
                )//.frame(width: 300, height: 200)
                .padding()
                
                VStack {
                    Spacer()
                    SmallShpaeIcons
                }
            }
            .background(Color(UIColor.systemGray6))
            .frame(height: 250).cornerRadius(20)
            .padding([.bottom, .horizontal])
            .shadow(color: Color(UIColor(white: 0, alpha: 0.5)), radius: 4, y: 3)
            
            //Previews
            ColorPreviews.frame(height: 30)
            
            //Wallpapers
            HStack {
                LightModeWallpaper
                    .shadow(color: Color(UIColor(white: 0, alpha: 0.5)), radius: 2, y: 2)
                DarkModeWallpaper
                    .shadow(color: Color(UIColor(white: 0, alpha: 0.5)), radius: 2, y: 2)
            }.padding([.bottom, .horizontal])
            
        }
        .padding(10)
        //Navigation
        .sheet(isPresented: $showsPicker, onDismiss: updateWallpaperSave) {
            ImagePicker(img: isPickingLight ? $bgBright : $bgDark)
        }
        .sheet(isPresented: $showsHelp) {
            InfoView(
                firstColor: colorScheme == .light ? $firstColorLight : $firstColorDark,
                secondColor: colorScheme == .light ? $secondColorLight : $secondColorDark
            )
        }
    }
    
    func setWallpaper() {showsPicker = true}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
