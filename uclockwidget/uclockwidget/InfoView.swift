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
                Text("Info & Help")
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
                VStack(alignment: .leading, spacing: 10) {
                    Group {
                        LeftLabel("square.on.square.dashed", "Setting the wallpaper")
                        Text("1. Go to home screen").padding(.leading)
                        Text("2. Enter edit mode").padding(.leading)
                        Text("3. Swipe to a new empty page").padding(.leading)
                        Text("4. Take a screenshot").padding(.leading)
                        Text("5. Repeat for light/dark mode").padding(.leading)
                        Text("6. Come back and choose them").padding(.leading)
                    }.font(.system(size: 18, weight: .semibold, design: .rounded))
                    
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
        .shadow(color: Color(UIColor(white: 0, alpha: 0.3)), radius: 2, x: 0, y: 1)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(firstColor: .constant(.red), secondColor: .constant(.blue))
    }
}
