//
//  ScallopClockView.swift
//  uclockwidget
//
//  Created by wyw on 2022/3/30.
//

import SwiftUI

struct UClockView: View {
    var dateFormat: String?
    var date: Date
    
    var firstColor: Color = Color.primary
    var secondColor: Color = Color.primary
    
    var showSeconds: Bool
    var showNumbers: Bool
    var shape: ClockShape
    var bordered: Bool
    var bg: UIImage?
    
    var hor: Double
    var mnt: Double
    var sec: Double
    
    @Environment(\.colorScheme) var colorScheme
    
    enum ClockShape: Int {
        case circle, scallop, clover
    }
    
    var dateFormatter: DateFormatter {
        let pattern = dateFormat ?? ""
        let fmt = DateFormatter()
        fmt.dateFormat = pattern
        return fmt
    }
    
    let shadowColor = Color(UIColor(white: 0, alpha: 0.4))
    
    var bgColor: Color {
        if let mainCGColor = firstColor.cgColor?.components {
            let mainOpacity: CGFloat = 0.1
            let mainComp = mainCGColor * mainOpacity
            let bgComp = [CGFloat](
                colorScheme == .light ? [1,1,1] : [0,0,0]
            ) * (1 - mainOpacity)
            return Color(red: (mainComp[0] + bgComp[0]),
                  green: (mainComp[1] + bgComp[1]),
                  blue: (mainComp[2] + bgComp[2])
            )
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
                        //背景
                        switch shape {
                        case .circle:
                            if !bordered {
                                Circle().fill()
                                    .shadow(
                                        color: Color(UIColor(white: 0, alpha: 0.4)),
                                        radius: 2, y: 2
                                    )
                            } else {
                                Circle().stroke(lineWidth: r * 0.1)
                            }
                        case .scallop:
                            if !bordered {
                                ScallopShape()
                                    .rotationEffect(Angle(degrees: 15))
                                    .shadow(
                                        color: Color(UIColor(white: 0, alpha: 0.4)),
                                        radius: 2, y: 2
                                    )
                            } else {
                                ScallopShape().stroke(lineWidth: r * 0.1)
                            }
                        case .clover:
                            if !bordered {
                                CloverShape()
                                    .shadow(
                                        color: Color(UIColor(white: 0, alpha: 0.4)),
                                        radius: 2, y: 2
                                    )
                            } else {
                                CloverShape().stroke(lineWidth: r * 0.1)
                            }
                        //default: fatalError()
                        }
                    }.foregroundColor(bgColor)
                    
                    Group {
                        //数字
                        if showNumbers {
                            ZStack {
                                Text("12").offset(y: -r * 0.56)
                                Text("3").offset(x: r * 0.56)
                                Text("6").offset(y: r * 0.56)
                                Text("9").offset(x: -r * 0.56)
                            }.font(.system(size: r * 0.59, weight: .black))//, design: .rounded))
                                .foregroundColor(firstColor)
                                .opacity(0.3)
                        }
                    }
                    
                    Group {
                        //时针
                        Color.black
                            .overlay(
                                firstColor.opacity(0.4)
                            ).mask(
                                Capsule().fill()
                                    .foregroundColor(.black)
                                    .frame(width: r * 0.14, height: r * 0.52)
                                    .offset(y: -r * 0.26 + r * 0.07)
                                    .rotationEffect(Angle(degrees: hor * 30 + mnt / 2))
                        )
                    }.shadow(color: shadowColor, radius: 1, y: 1)
                    
                    Group {
                        //分针
                        if shape == .scallop {
                            Color(UIColor.systemBackground)//.white
                                .overlay(
                                    secondColor.opacity(0.8)
                                ).mask(
                                    Capsule().fill()
                                        .frame(width: r * 0.14, height: r * 0.70)
                                        .offset(y: -r * 0.35 + r * 0.07)
                                        .rotationEffect(Angle(degrees: mnt * 6))
                            )
                        } else {
                            Capsule().fill()
                                .foregroundColor(secondColor)
                                .frame(width: r * 0.08, height: r * 0.8)
                                .offset(y: -r * 0.4 + r * 0.04)
                                .rotationEffect(Angle(degrees: mnt * 6))
                        }
                    }.shadow(color: shadowColor, radius: 1, y: 1)
                    
                    Group {
                        //秒针
                        if showSeconds {
                            if shape == .scallop {
                                VStack {
                                    DateText(r)
                                    Spacer()
                                    Circle().fill()
                                        .foregroundColor(firstColor)//.pink)
                                        .opacity(0.7)
                                        .frame(width: r * 0.16, height: r * 0.16)
                                        .padding(r * 0.12)
                                }.rotationEffect(Angle(degrees: sec * 6 + 180))
                            } else {
                                Capsule().fill()
                                    .foregroundColor(firstColor)//.pink)
                                    .frame(width: r * 0.04, height: r * 0.88)
                                    .offset(y: r * 0.44 - r * 0.02)
                                    .rotationEffect(Angle(degrees: sec * 6 + 180))
                            }
                            
    //                        } else {
    //                            VStack {
    //                                DateText(r)
    //                                Spacer()
    //                            }
                        }
                    }.shadow(color: shadowColor, radius: 1, y: 1)
                    
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

func *(_ lhs: [CGFloat], _ rhs: CGFloat) -> [CGFloat] {
    lhs.map({$0 * rhs})
}

struct FlowerClockView_Previews: PreviewProvider {
    static var previews: some View {
        UClockView(
            dateFormat: nil,
            date: Date(),
            firstColor: Color.red,
            secondColor: Color.blue,
            showSeconds: true,
            showNumbers: true,
            shape: .scallop,
            bordered: false,
            hor: 10, mnt: 35, sec: 35
        )
        .background(Color.gray)
        .previewInterfaceOrientation(.portrait)
    }
}
