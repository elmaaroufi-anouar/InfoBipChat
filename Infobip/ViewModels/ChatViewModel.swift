//
//  ChatViewModel.swift
//  Infobip
//
//  Created by Anouar El Maaroufi on 30/5/2025.
//

import Foundation
import InAppChat

class ChatViewModel: ObservableObject {
    @Published var text: String = ""

    // media state
    @Published var showImagePicker: Bool = false
    @Published var showCamera: Bool = false

    // for alert
    @Published var showAlert: Bool = false
    @Published var errorText: String = ""

    // for chat state
    @Published var chatState: MMChatWebViewState? = .unknown
    var chatController: MMChatViewController?

    func sendText(_ text: String) {
        let payload = text.livechatBasicPayload
        chatController?.send(payload) { error in
            if let error = error {
                self.errorText = "Error: \(error.localizedDescription)"
                self.showAlert = true
            }
        }
    }

    func sendImage(_ image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        let payload = MMLivechatBasicPayload(data: imageData)

        chatController?.send(payload) { error in
            if let error = error {
                self.errorText = "Error: \(error.localizedDescription)"
                self.showAlert = true                
            }
        }
    }
}
