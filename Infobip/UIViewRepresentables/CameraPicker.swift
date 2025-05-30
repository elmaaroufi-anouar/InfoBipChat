//
//  CameraPicker.swift
//  Infobip
//
//  Created by Anouar El Maaroufi on 29/5/2025.
//

import SwiftUI
import UIKit

struct CameraPicker: UIViewControllerRepresentable {
    @Environment(\.dismiss) var dismiss
    var didFinishTakingPhoto: ((UIImage) -> Void)?

    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        
        return picker
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: CameraPicker

        init(_ parent: CameraPicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.didFinishTakingPhoto?(uiImage)
            }
            
            parent.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}
