//
//  FlowerClockView.swift
//  uclockwidget
//
//  Created by wyw on 2022/3/30.
//

import SwiftUI

struct FlowerClockView: View {
    var dateFormat: String?
    //var backgroundColor: Color
    var fingerColorHue: Double
    
    var showSeconds: Bool
    var showNumbers: Bool
    var shape: ClockShape
    
    var hor: Double
    var mnt: Double
    var sec: Double
    
    enum ClockShape: Int {
        case rounded, roundedBorder, flower, flowerBorder
    }
    
    var body: some View {
        GeometryReader {geo in
            let r = min(geo.size.width, geo.size.height) / 2
            ZStack {
                switch shape {
                case .rounded:
                    Circle().fill()
                        .foregroundColor(Color(hue: fingerColorHue, saturation: 0.2, brightness: 0.9))
                case .roundedBorder:
                    Circle().strokeBorder(lineWidth: r * 0.1)
                        .foregroundColor(Color(hue: fingerColorHue, saturation: 0.2, brightness: 0.9))
                case .flower:
                    FlowerClockShape()
                        .fill().foregroundColor(Color(hue: fingerColorHue, saturation: 0.2, brightness: 0.9))
                case .flowerBorder:
                    FlowerClockShape().stroke(lineWidth: r * 0.1)
                        .foregroundColor(Color(hue: fingerColorHue, saturation: 0.2, brightness: 0.9))
                }
                
                if showNumbers {
                    ZStack {
                        Text("12").offset(y: -r * 0.5)
                        Text("3").offset(x: r * 0.5)
                        Text("6").offset(y: r * 0.5)
                        Text("9").offset(x: -r * 0.5)
                    }.font(.system(size: r * 0.57, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .opacity(0.5)
                }
                
                if showSeconds {
                    VStack {
                        DateText(r)
                        Spacer()
                        Circle().fill()
                            .foregroundColor(Color(UIColor.systemGray4))
                            .frame(width: r * 0.16, height: r * 0.16)
                            .padding(r * 0.22)
                    }
                    .rotationEffect(Angle(degrees: sec * 6 + 180))
                } else {
                    VStack {
                        DateText(r)
                        Spacer()
                    }
                }
                
                Capsule().fill()
                    .foregroundColor(Color(hue: fingerColorHue, saturation: 0.8, brightness: 0.91))
                    .frame(width: r * 0.16, height: r * 0.48)
                    .offset(y: -r * 0.24 + r * 0.08)
                    .rotationEffect(Angle(degrees: hor * 30 + mnt / 2))
                Capsule().fill()
                    .foregroundColor(Color(hue: fingerColorHue, saturation: 0.45, brightness: 0.98))
                    .frame(width: r * 0.16, height: r * 0.6)
                    .offset(y: -r * 0.3 + r * 0.08)
                    .rotationEffect(Angle(degrees: mnt * 6))
                
            }.frame(width: r * 2, height: r * 2, alignment: .center)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    @ViewBuilder
    func DateText(_ r: CGFloat) -> some View {
        Text("Sat 10")
            .font(.system(size: r * 0.15, weight: .regular, design: .rounded))
            .foregroundColor(Color(hue: fingerColorHue, saturation: 0.8, brightness: 0.91))
            .padding(r * 0.22)
    }
}

struct FlowerClockView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerClockView(
            dateFormat: "EE dd",
            fingerColorHue: 0.7,
            showSeconds: true,
            showNumbers: true,
            shape: .flower,
            hor: 10, mnt: 35, sec: 20
        )//.frame(width: 300, height: 200)
        .background(Color.gray)
    }
}
