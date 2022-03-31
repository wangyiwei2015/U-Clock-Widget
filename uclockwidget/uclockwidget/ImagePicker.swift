//
//  ImagePicker.swift
//  uclockwidget
//
//  Created by wyw on 2022/3/31.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var img: UIImage?
    
    let picker = UIImagePickerController()
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        picker.delegate = context.coordinator
        picker.sourceType = .savedPhotosAlbum
        return picker
    }
    
    func makeCoordinator() -> ImagePickerCoordinator {
        ImagePickerCoordinator(selectedImage: $img)
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Binding private var selectedImage: UIImage?

    init(selectedImage: Binding<UIImage?>) {
        _selectedImage = selectedImage
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectedImage = (info[.originalImage] as! UIImage)
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
