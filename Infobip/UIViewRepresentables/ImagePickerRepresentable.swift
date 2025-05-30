//
//  ImagePickerRepresentable.swift
//  Infobip
//
//  Created by Anouar El Maaroufi on 30/5/2025.
//

import SwiftUI

struct ImagePickerRepresentable: UIViewControllerRepresentable {
    @Binding var isPresenting: Bool
    var didFinishPickingWithImage: ((UIImage) -> Void)?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePickerRepresentable
        init(_ parent: ImagePickerRepresentable) {
            self.parent = parent
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.didFinishPickingWithImage?(uiImage)
                parent.isPresenting = false
            }
        }
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }
}
