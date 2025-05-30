//
//  InputToolBar.swift
//  Infobip
//
//  Created by Anouar El Maaroufi on 29/5/2025.
//

import SwiftUI
import PhotosUI

extension View {
    func transparentScrolling() -> some View {
        if #available(iOS 16.0, *) {
            return scrollContentBackground(.hidden)
        } else {
            return onAppear {
                UITextView.appearance().backgroundColor = .clear
            }
        }
    }
}

struct TextEditorView: View {
    @Binding var text: String
    @FocusState.Binding var isFocusedInput: Bool
    var fixedHorizontal: Bool = false
    var fixedVertical: Bool = true
    
    // These control the sizing
    private let maxHeight: CGFloat = 120
    private let minHeight: CGFloat = 36

    var body: some View {
        UITextView.appearance().backgroundColor = .clear
        
        return VStack {
            Text(text)
                .frame(maxWidth: .infinity, maxHeight: maxHeight)
                .hidden()
                .overlay {
                    TextEditor(text: $text)
//                        .padding(.horizontal, -5.0)
//                        .padding(.vertical, -8.0)
//                        .padding(.horizontal, 7)
                        .focused($isFocusedInput)
                        .font(.Done.regular(size: 18))
                        .frame(minHeight: minHeight, maxHeight: maxHeight)
                        .transparentScrolling()
                        
                }
                .fixedSize(horizontal: fixedHorizontal, vertical: fixedVertical)
        }
    }
}

struct InputToolBar: View {
    @Binding var text: String
    @FocusState private var isInputFocused: Bool
    @State private var selectedImage: UIImage?
    @State private var showActionSheet = false
    @State private var showCamera = false
    @State private var showPhotoLibrary = false

    var onSendDidTap: (String) -> Void
    var onAttachmentDidTap: () -> Void
    
    var body: some View {
        HStack(spacing: 15) {
            HStack {
                TextEditorView(text: $text, isFocusedInput: $isInputFocused)

                Button {
                    onSendDidTap(text)
                    text = ""
                } label: {
                    Image("send")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(Color(hex: isInputFocused ? 0xFFFFFF: 0xF4F4F4))
            .clipShape(.rect(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(hex: isInputFocused ? 0xDDDDDD : 0xF4F4F4), lineWidth: 1)
            )

            Button {
                showActionSheet = true
            } label: {
                Image("camera_icon")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 30, height: 30)
            }

            // Audio input
            Button {
                // Send an audio
            } label: {
                Image("voice_icon")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 30, height: 30)
            }
        }
        .padding()
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(hex: 0xDEDEDE))
            , alignment: .top
        )
        .confirmationDialog("Show Image Source", isPresented: $showActionSheet) {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                Button ("Take Photo") {
                    showCamera = true
                }
            }

            Button("Choose from Library") {
//                showPhotoLibrary = true
                onAttachmentDidTap()
            }

            Button("Cancel", role: .cancel) {}
        }
        .sheet(isPresented: $showCamera) {
            CameraPicker(image: $selectedImage)
        }
        .background(.white)
    }
}

//#Preview {
//    InputToolBar(onSendDidTap: {_ in }, onAttachmentDidTap: {})
//}
