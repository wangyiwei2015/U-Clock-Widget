//
//  DebugView.swift
//  uclockwidget
//
//  Created by wyw on 2022/5/13.
//

import SwiftUI

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
