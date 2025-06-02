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
    
    func neverDismissKeyboardOnScroll() -> some View {
        if #available(iOS 16.0, *) {
            return scrollDismissesKeyboard(.never)
        } else {
            return onAppear {
                UIScrollView.appearance().keyboardDismissMode = .none
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
    private let minHeight: CGFloat = 40
    
    var body: some View {
        VStack {
            Text(text)
                .frame(maxWidth: .infinity, minHeight: minHeight, maxHeight: maxHeight)
                .hidden()
                .overlay {
                    TextEditor(text: $text)
                        .focused($isFocusedInput)
                        .font(.Done.regular(size: 18))
                        .foregroundStyle(Color.black)
                        .frame(minHeight: minHeight, maxHeight: maxHeight)
                        .transparentScrolling()
                        .neverDismissKeyboardOnScroll()
                        
                }
                .clipped()
                .fixedSize(horizontal: fixedHorizontal, vertical: fixedVertical)
        }
    }
}

struct InputToolBar: View {
    @Binding var text: String
    @FocusState private var isInputFocused: Bool
    @State private var selectedImage: UIImage?
    @State private var showActionSheet = false

    var onSendDidTap: (String) -> Void
    var onAttachmentDidTap: () -> Void
    var onCameraDidTap: () -> Void

    var body: some View {
        HStack(spacing: text.isEmpty ? 15 : 0) {
            HStack (alignment: .bottom){
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
                .opacity(text.isEmpty ? 0 : 1)
                .disabled(text.isEmpty)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(Color(hex: isInputFocused ? 0xFFFFFF: 0xF4F4F4))
            .clipShape(.rect(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(hex: isInputFocused ? 0xDDDDDD : 0xF4F4F4), lineWidth: 1)
            )
            .animation(.default, value: text.isEmpty)
            .onTapGesture {
                isInputFocused = true
            }

            // camera and audio buttons
            HStack {
                if (text.isEmpty)
                {
                    Button {
                        showActionSheet = true
                    } label: {
                        Image("camera_icon")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                    }
                    
                    // Audio input will be added later
                    /*
                    Button {
                        // Send an audio
                    } label: {
                        Image("voice_icon")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                    }
                     */
                }
            }
            .animation(.default, value: text.isEmpty)
        }
        .padding()
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(hex: 0xDEDEDE))
            , alignment: .top
        )
        .confirmationDialog("Show Image Source", isPresented: $showActionSheet) {
            Button ("Take Photo") {
                onCameraDidTap()
            }

            Button("Choose from Library") {
                onAttachmentDidTap()
            }

            Button("Cancel", role: .cancel) {}
        }
        .background(.white)
    }
}
