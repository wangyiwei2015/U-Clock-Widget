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
//            Color.green
//                .frame(
//                    width: WidgetCropPostion.smallTopLeft.getRect().width,
//                    height: WidgetCropPostion.smallTopLeft.getRect().height
//                )
//                .position(
//                    x: WidgetCropPostion.smallCenterLeft.getRect().midX,
//                    y: WidgetCropPostion.smallCenterLeft.getRect().midY
//                )
//                .opacity(0.5)
//            Text("DEBUG\n\(WidgetCropPostion.smallTopLeft.getRect().debugDescription)\n\(UIDevice().type.rawValue)\n\(UIScreen.main.bounds.size.debugDescription)\n")//\(String(validatingUTF8: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"]!)!)")
//                .foregroundColor(.white)
//                .position(
//                    x: WidgetCropPostion.smallCenterLeft.getRect().midX,
//                    y: WidgetCropPostion.smallCenterLeft.getRect().midY
//                )
        }.ignoresSafeArea()
    }
}
#endif
