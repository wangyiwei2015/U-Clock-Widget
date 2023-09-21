//
//  ContentView.swift
//  uclockwidget
//
//  Created by wyw on 2022/3/30.
//

import SwiftUI
import Transparency

struct ContentView: View {
    @State var hor: Int = 0
    
    @State var bgBright: UIImage? = try? UIImage(data: Data(contentsOf: URL(fileURLWithPath: "\(imgPath)/imgB.jpg")))
    @State var bgDark: UIImage? = try? UIImage(data: Data(contentsOf: URL(fileURLWithPath: "\(imgPath)/imgD.jpg")))
    
    @State var isPickingLight = true
    @State var showsPicker = false
    @State var showsHelp = false
    @State var errAlert = false
    @State var launchedBefore = UserDefaults.standard.bool(forKey: "_LAUNCHED")
    @State var isiPad: Bool = UIDevice.current.userInterfaceIdiom != .phone
    
    @State var previewShape: UClockView.ClockShape = .scallop
    
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
    
    let bgGen = WidgetBackground()
    
    var body: some View {
        ZStack {
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
                        showSeconds: true,
                        showNumbers: true,
                        shape: previewShape, bordered: false,
                        hor: 10, mnt: 8, sec: 22
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
                }.padding(.horizontal).padding(.bottom, 8)
                Button {
                    postSaveWall()
                    UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                } label: {
                    Image(systemName: "house.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.gray)
                        .ignoresSafeArea()
                }
            }
            if isiPad {
                Color(UIColor.systemBackground).opacity(0.8)
                Text("ipad_err")
                    .frame(width: 200)
                    .padding(30)
                    .background(
                        Color(UIColor.systemBackground)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                    )
            }
        }
        .padding(10)
        //Navigation
        .onAppear {
            if !launchedBefore {
                UserDefaults.standard.set(true, forKey: "_LAUNCHED")
                if !isiPad {
                    showsHelp = true
                }
                //print(UIDevice.current.type.rawValue)
            }
        }
        .sheet(isPresented: $showsPicker, onDismiss: updateWallpaperSave) {
            ImagePicker(
                isLightImg: $isPickingLight, imgL: $bgBright, imgD: $bgDark
            )
        }
        .sheet(isPresented: $showsHelp) {
            InfoView(
                firstColor: colorScheme == .light ? $firstColorLight : $firstColorDark,
                secondColor: colorScheme == .light ? $secondColorLight : $secondColorDark
            )
        }
        .alert("_invalid_wall", isPresented: $errAlert, actions: {Button("Dismiss"){}})
        #if(DEBUG)
        .fullScreenCover(isPresented: .constant(false)) {DebugView(wall: $bgBright)}
        #endif
    }
    
    func setWallpaper() {showsPicker = true}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(launchedBefore: true)
    }
}
