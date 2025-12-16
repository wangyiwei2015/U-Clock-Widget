//
//  InfoView.swift
//  PxClock
//
//  Created by leo on 2025.12.16.
//

//
//  InfoView.swift
//  uclockwidget
//
//  Created by wyw on 2022/5/4.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.presentationMode) var mode
    @Binding var firstColor: Color
    @Binding var secondColor: Color
    
    var body: some View {
        VStack {
            HStack {
                Text("info_title")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(secondColor)
                    .shadow(color: Color(UIColor(white: 0, alpha: 0.3)), radius: 2, x: 0, y: 1)
                Spacer()
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.gray)
                }
            }.padding()
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    Group {
                        VStack(alignment: .leading, spacing: 10) {
                            LeftLabel("square.on.square.dashed", "set_wall")
                            Text("sw1").padding(.leading)
                            Text("sw2").padding(.leading)
                            Text("sw3").padding(.leading)
                            Text("sw4").padding(.leading)
                            Text("sw5").padding(.leading)
                            Text("sw6").padding(.leading)
                        }.font(.system(size: 20, weight: .regular))
                    }.padding(.bottom)
                    
                    Group {
                        VStack(alignment: .leading, spacing: 10) {
                            LeftLabel("chevron.left.forwardslash.chevron.right", "open_source")
                            Text("transparent").padding(.leading)
                            Link("wangyiwei2015 / Transparency ↗", destination: URL(string: "https://github.com/wangyiwei2015/Transparency")!)
                                .tint(secondColor).padding(.leading).shadow(color: Color(UIColor(white: 0, alpha: 0.3)), radius: 1, x: 0, y: 01)
                            Text("colorext").padding(.leading)
                            Link("yamoridon / ColorThiefSwift ↗", destination: URL(string: "https://github.com/yamoridon/ColorThiefSwift")!)
                                .tint(secondColor).padding(.leading).shadow(color: Color(UIColor(white: 0, alpha: 0.3)), radius: 1, x: 0, y: 1)
                        }.font(.system(size: 20, weight: .regular))
                    }.padding(.bottom)
                    
                    Group {
                        VStack(alignment: .leading, spacing: 10) {
                            LeftLabel("info.circle", "about")
                            Text("project_info").padding(.leading)
                            Link("link_github", destination: URL(string: "https://github.com/wangyiwei2015/U-Clock-Widget")!)
                                .tint(secondColor).padding(.leading).shadow(color: Color(UIColor(white: 0, alpha: 0.3)), radius: 1, x: 0, y: 1)
                            Text("rate_text").padding(.leading)
                            Link("link_appstore", destination: URL(string: "itms-apps://itunes.apple.com/cn/app/id1622170600")!)
                                .tint(secondColor).padding(.leading).shadow(color: Color(UIColor(white: 0, alpha: 0.3)), radius: 1, x: 0, y: 1)
                            Text("contact_text").padding(.leading)
                            Link("link_email", destination: URL(string: "mailto:wanyw.dev@outlook.com?subject=UClock%20Feedback")!)
                                .tint(secondColor).padding(.leading).shadow(color: Color(UIColor(white: 0, alpha: 0.3)), radius: 1, x: 0, y: 1)
                        }.font(.system(size: 20, weight: .regular))
                    }.padding(.bottom)
                    
                    HStack {
                        Text("v\(ver)(\(build))")
                        Image(systemName: "swift")
                        Text("SwiftUI")
                    }.font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.gray)
                        .padding(.top)
                }.padding()
            }
        }
    }
    
    @ViewBuilder
    func LeftLabel(_ img: String, _ text: String) -> some View {
        HStack {
            Image(systemName: img)
                .font(.system(size: 30, weight: .semibold))
            Text(text).bold()
            Spacer()
        }.font(.system(size: 24, weight: .semibold))
        .foregroundColor(firstColor)
        .shadow(color: Color(UIColor(white: 0, alpha: 0.3)), radius: 2, x: 0, y: 2)
    }
    
    let ver = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String? ?? "0"
    let build = Bundle.main.infoDictionary!["CFBundleVersion"] as! String? ?? "0"
}

#Preview {
    InfoView(firstColor: .constant(.red), secondColor: .constant(.blue))
}

#if(DEBUG)
struct DebugView: View {
    
    @Binding var wall: UIImage?
    //let bg = try! UIImage(data: Data(contentsOf: URL(fileURLWithPath: "\(imgPath)/imgB1.jpg")))
    
    var body: some View {
        ZStack {
            if let wall = wall {
                Image(uiImage: wall).resizable()
            }
        }.ignoresSafeArea()
    }
}
#endif
