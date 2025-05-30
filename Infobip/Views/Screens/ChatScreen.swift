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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePickerRepresentable(isPresenting: $viewModel.showImagePicker) { image in
                viewModel.sendImage(image)
            }
        }
        .fullScreenCover(isPresented: $viewModel.showCamera) {
            CameraPicker { image in
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
    }

    @ViewBuilder func makeChat() -> some View {
        let chatView = ChatViewRepresentable(shouldUseCustomChatInput: true, chatState: $viewModel.chatState)
        chatView
            .navigationBarBackButtonHidden(true)
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
            }, onCameraDidTap: {
                viewModel.showCamera = true
            })
        }
    }
}

#Preview {
    ChatScreen()
}
