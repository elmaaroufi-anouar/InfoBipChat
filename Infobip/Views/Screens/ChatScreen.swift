//
//  ChatScreen.swift
//  Infobip
//
//  Created by Anouar El Maaroufi on 29/5/2025.
//

import SwiftUI

struct ChatScreen: View {
    @StateObject private var viewModel = ChatViewModel()

    var body: some View {
        VStack {
            ChatTopBar()
            makeChat()
            makeChatInput()
        }
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePickerRepresentable(isPresenting: $viewModel.showImagePicker) { image in
                viewModel.sendImage(image)
            }
        }
        .alert(isPresented: $viewModel.showAlert, content: {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorText),
                dismissButton: .default(Text("OK"))
            )
        })
        .onChange(of: viewModel.chatState) { newState in
            print("Chat state changed to: \(String(describing: newState))")
        }
        .navigationBarHidden(true)
    }

    @ViewBuilder func makeChat() -> some View {
        let chatView = ChatViewRepresentable(shouldUseCustomChatInput: true, chatState: $viewModel.chatState)
        chatView
            .onAppear {
                viewModel.chatController = chatView.chatController
            }
    }

    @ViewBuilder func makeChatInput() -> some View {
        switch viewModel.chatState {
            case .loading, .threadList, .closedThread, .unknown, .loadingThread: EmptyView()
        default:
            InputToolBar(text: $viewModel.text, onSendDidTap: { text in
                viewModel.sendText(text)
            }, onAttachmentDidTap: {
                viewModel.showImagePicker = true
            })
        }
    }
}

#Preview {
    ChatScreen()
}
