//
//  InfoView.swift
//  uclockwidget
//
//  Created by wyw on 2022/5/4.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        VStack {
            HStack {
                Text("Info & Help")
                    .font(.system(size: 24, weight: .semibold))
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
                    }
                }.padding()
            }
        }
    }
    
    @ViewBuilder
    func LeftLabel(_ img: String, _ text: String) -> some View {
        HStack {
            Image(systemName: img)
                .font(.system(size: 30, weight: .semibold))
                .foregroundColor(.gray)
            Text(text).bold()
            Spacer()
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
