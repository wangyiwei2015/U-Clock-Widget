//
//  ImagePicker.swift
//  uclockwidget
//
//  Created by wyw on 2022/3/31.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var isLightImg: Bool
    @Binding var imgL: UIImage?
    @Binding var imgD: UIImage?
    
    let picker = UIImagePickerController()
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        picker.delegate = context.coordinator
        picker.sourceType = .savedPhotosAlbum
        return picker
    }
    
    func makeCoordinator() -> ImagePickerCoordinator {
        ImagePickerCoordinator(
            $isLightImg,
            selectedImageL: $imgL,
            selectedImageD: $imgD
        )
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Binding var isLightImg: Bool
    @Binding var imgL: UIImage?
    @Binding var imgD: UIImage?

    init(_ isLight: Binding<Bool>, selectedImageL: Binding<UIImage?>, selectedImageD: Binding<UIImage?>) {
        _imgL = selectedImageL
        _imgD = selectedImageD
        _isLightImg = isLight
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImg = (info[.originalImage] as! UIImage)
        if isLightImg {
            imgL = chosenImg
        } else {
            imgD = chosenImg
        }
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
