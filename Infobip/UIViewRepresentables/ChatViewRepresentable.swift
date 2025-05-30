//
//  ChatViewRepresentable.swift
//  Infobip
//
//  Created by Anouar El Maaroufi on 30/5/2025.
//

import SwiftUI
import MobileMessaging
import InAppChat

struct ChatViewRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = MMChatViewController

    let chatController = MMChatViewController()
    private let shouldUseCustomChatInput: Bool

    @Binding var chatState: MMChatWebViewState?

    init(shouldUseCustomChatInput: Bool, chatState: Binding<MMChatWebViewState?>) {
        self.shouldUseCustomChatInput = shouldUseCustomChatInput
        self._chatState = chatState
    }

    func makeUIViewController(context: Context) -> MMChatViewController {
        MMChatSettings.sharedInstance.shouldHandleKeyboardAppearance = false
        MMChatSettings.sharedInstance.shouldUseExternalChatInput = shouldUseCustomChatInput
        
        // set widget theme
        chatController.setWidgetTheme("Done") { error in
            print(">>>>Theme changed with: " + (error?.localizedDescription ?? "Success"))
        }
        return chatController
    }

    func updateUIViewController(_ uiViewController: MMChatViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MMInAppChatDelegate {
        let parent: ChatViewRepresentable
        init(_ parent: ChatViewRepresentable) {
            self.parent = parent
            super.init()
            if parent.chatState != nil {
                MobileMessaging.inAppChat?.delegate = self
            }
        }

        func chatDidChange(to state: MMChatWebViewState) {
            parent.chatState = state
        }
    }
}
