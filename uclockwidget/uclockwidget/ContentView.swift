//
//  ContentView.swift
//  uclockwidget
//
//  Created by wyw on 2022/3/30.
//

import SwiftUI
import ColorThiefSwift

struct ContentView: View {
    @State var hor: Int = 0
    
    @State var bgBright: UIImage? = try? UIImage(data: Data(contentsOf: URL(fileURLWithPath: "\(imgPath)/imgB.jpg")))
    @State var bgDark: UIImage? = try? UIImage(data: Data(contentsOf: URL(fileURLWithPath: "\(imgPath)/imgD.jpg")))
    
    @State var isPickingLight = true
    @State var showsPicker = false
    
    @State var showsHelp = false
    
    var body: some View {
        VStack {
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
            ZStack {
                FlowerClockView(
                    dateFormat: "EE dd",
                    date: Date(),
                    fingerColorHue: nil,
                    showSeconds: true,
                    showNumbers: true,
                    shape: .flower, bordered: false,
                    hor: 10, mnt: 35, sec: 20
                )//.frame(width: 300, height: 200)
                .padding()
                
                VStack {
                    Spacer()
                    HStack(spacing: 5) {
                        Image(systemName: "seal")
                        Image(systemName: "seal.fill")
                        Image(systemName: "circle")
                        Image(systemName: "circle.fill")
                        Spacer()
                    }
                    .font(.system(size: 16, weight: .black))
                    .foregroundColor(Color(UIColor.systemGray4))
                    .padding(10)
                }
            }
            .background(Color(UIColor.systemGray6))
            .frame(height: 250)
            .cornerRadius(20)
            .padding([.bottom, .horizontal])
            
            HStack {
                Image(uiImage: bgBright ?? UIImage())
                    .resizable()
                    .aspectRatio(UIScreen.main.bounds.width / UIScreen.main.bounds.height, contentMode: .fit)
                    .overlay(AutoPlusSymbol(for: bgBright))
                    .background(Color(white: 0.9))
                    .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .onTapGesture {
                        isPickingLight = true
                        setWallpaper()
                    }
                    .padding()
                Image(uiImage: bgDark ?? UIImage())
                    .resizable()
                    .aspectRatio(UIScreen.main.bounds.width / UIScreen.main.bounds.height, contentMode: .fit)
                    .overlay(AutoPlusSymbol(for: bgDark))
                    .background(Color(white: 0.3))
                    .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .onTapGesture {
                        isPickingLight = false
                        setWallpaper()
                    }
                    .padding()
            }.padding()
        }
        .sheet(isPresented: $showsPicker, onDismiss: updateWallpaperSave) {
            ImagePicker(img: isPickingLight ? $bgBright : $bgDark)
        }
        .sheet(isPresented: $showsHelp) {
            InfoView()
        }
    }
    
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
    
    func setWallpaper() {showsPicker = true}
    
    func updateWallpaperSave() {
        if let brightImg = bgBright {
            try! brightImg.jpegData(compressionQuality: 1.0)?.write(to: URL(fileURLWithPath: "\(imgPath)/imgB.jpg"), options: .atomic)
            let theme = ColorThief.getColor(from: brightImg)!
            var hue: CGFloat = 0
            theme.makeUIColor().getHue(&hue, saturation: nil, brightness: nil, alpha: nil)
            UserDefaults.standard.set(Double(hue), forKey: "_IMG_COLOR")
            for pos in 1...9 {
                let img = cropImage(brightImg, toRect: WidgetCropPostion(rawValue: pos - 1)!.getRect())!
                try! img.jpegData(compressionQuality: 1.0)!.write(to: URL(fileURLWithPath: "\(imgPath)/imgB\(pos).jpg"), options: .atomic)
            }
        }
        if let darkImg = bgDark {
            try! darkImg.jpegData(compressionQuality: 1.0)?.write(to: URL(fileURLWithPath: "\(imgPath)/imgD.jpg"), options: .atomic)
            for pos in 1...9 {
                let img = cropImage(darkImg, toRect: WidgetCropPostion(rawValue: pos - 1)!.getRect())!
                try! img.jpegData(compressionQuality: 1.0)!.write(to: URL(fileURLWithPath: "\(imgPath)/imgD\(pos).jpg"), options: .atomic)
            }
        }
        print(imgPath)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
