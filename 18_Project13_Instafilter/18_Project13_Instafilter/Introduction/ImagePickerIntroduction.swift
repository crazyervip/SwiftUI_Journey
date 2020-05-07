//
//  ImagePicker.swift
//  18_Project13_Instafilter
//
//  Created by Jacob Zhang on 2020/5/5.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct ImagePickerIntroduction: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode

    @Binding var image: UIImage?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerIntroduction>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerIntroduction>) {
        // not used in this case
    }

    func makeCoordinator() -> CoordinatorIntroduction {
        CoordinatorIntroduction(self)
    }

    // NOT the coordinator pattern
    class CoordinatorIntroduction: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePickerIntroduction

        init(_ parent: ImagePickerIntroduction) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
