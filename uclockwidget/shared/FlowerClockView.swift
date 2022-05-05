//
//  FlowerClockView.swift
//  uclockwidget
//
//  Created by wyw on 2022/3/30.
//

import SwiftUI

struct FlowerClockView: View {
    var dateFormat: String?
    var date: Date
    //var backgroundColor: Color
    var fingerColorHue: Double? //nil for b&w
    
    var showSeconds: Bool
    var showNumbers: Bool
    var shape: ClockShape
    var bordered: Bool
    var bg: UIImage?
    
    var hor: Double
    var mnt: Double
    var sec: Double
    
    enum ClockShape: Int {
        case rounded, roundedBorder, flower, flowerBorder
    }
    
    var dateFormatter: DateFormatter {
        let pattern = dateFormat ?? ""
        let fmt = DateFormatter()
        fmt.dateFormat = pattern
        return fmt
    }
    
    var firstColor: Color {
        if let hue = fingerColorHue {
            return Color(hue: hue, saturation: 0.8, brightness: 0.91)
        } else {
            return Color(UIColor.systemGray)
        }
    }
    var secondColor: Color {
        if let hue = fingerColorHue {
            return Color(hue: hue, saturation: 0.45, brightness: 0.98)
        } else {
            return Color(UIColor.systemGray3)
        }
    }
    var bgColor: Color {
        if let hue = fingerColorHue {
            return Color(hue: hue, saturation: 0.2, brightness: 0.9)
        } else {
            return Color(UIColor.systemBackground)
        }
    }
    
    var body: some View {
        ZStack {
            if let img = bg {
                Image(uiImage: img).resizable().scaledToFill().ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            GeometryReader {geo in
                let r = min(geo.size.width, geo.size.height) / 2
                ZStack {
                    
                    Group {
                        switch shape {
                        case .rounded:
                            if !bordered {
                                Circle().fill()
                            } else {
                                Circle().strokeBorder(lineWidth: r * 0.1)
                            }
                        case .flower:
                            if !bordered {
                                FlowerClockShape()
                            } else {
                                FlowerClockShape().stroke(lineWidth: r * 0.1)
                            }
                        default: fatalError()
                        }
                    }.foregroundColor(bgColor)
                    
                    Group {
                        if showNumbers {
                            ZStack {
                                Text("12").offset(y: -r * 0.5)
                                Text("3").offset(x: r * 0.5)
                                Text("6").offset(y: r * 0.5)
                                Text("9").offset(x: -r * 0.5)
                            }.font(.system(size: r * 0.57, weight: .black, design: .rounded))
                                .foregroundColor(Color(UIColor.systemGray5))
                                .opacity(0.55)
                        }
                        
                        if showSeconds {
                            VStack {
                                DateText(r)
                                Spacer()
                                Circle().fill()
                                    .foregroundColor(Color(UIColor.systemGray5))
                                    .opacity(0.7)
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
                    }
                    
                    Capsule().fill()
                        .foregroundColor(firstColor)
                        .frame(width: r * 0.16, height: r * 0.48)
                        .offset(y: -r * 0.24 + r * 0.08)
                        .rotationEffect(Angle(degrees: hor * 30 + mnt / 2))
                    Capsule().fill()
                        .foregroundColor(secondColor)
                        .frame(width: r * 0.16, height: r * 0.6)
                        .offset(y: -r * 0.3 + r * 0.08)
                        .rotationEffect(Angle(degrees: mnt * 6))
                    
                }.frame(width: r * 2, height: r * 2, alignment: .center)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }.padding()
        }
    }
    
    @ViewBuilder
    func DateText(_ r: CGFloat) -> some View {
        Text(dateFormatter.string(from: date))
            .font(.system(size: r * 0.15, weight: .regular, design: .rounded))
            .foregroundColor(firstColor)
            .padding(r * 0.22)
    }
}

struct FlowerClockView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerClockView(
            dateFormat: nil,
            date: Date(),
            fingerColorHue: nil,
            showSeconds: true,
            showNumbers: true,
            shape: .flower,
            bordered: false,
            hor: 10, mnt: 35, sec: 25
        )
        .background(Color.gray)
        .previewInterfaceOrientation(.portrait)
    }
}
