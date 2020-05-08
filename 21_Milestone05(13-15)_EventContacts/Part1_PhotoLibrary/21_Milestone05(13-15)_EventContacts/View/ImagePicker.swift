//
//  ImagePicker.swift
//  18_Project13_Instafilter
//
//  Created by Jacob Zhang on 2020/5/5.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?

    @Binding var sourceType: UIImagePickerController.SourceType


    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> ImagePicker.Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        // 解决相机取图，图片方向颠倒问题 https://stackoverflow.com/questions/8915630
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = fixImageOrientation(for: uiImage)
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

        // 解决相机取图，图片方向颠倒问题 https://stackoverflow.com/questions/8915630
        private func fixImageOrientation(for image: UIImage) -> UIImage {
            UIGraphicsBeginImageContext(image.size)
            image.draw(at: .zero)
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return rotatedImage ?? image
        }
    }
}
