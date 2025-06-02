//
//  DynamicTextEditor.swift
//  Infobip
//
//  Created by Anouar El Maaroufi on 2/6/2025.
//

import SwiftUI

struct DynamicTextEditor: UIViewRepresentable {
    @Binding var text: String
    @Binding var dynamicHeight: CGFloat
    @Binding var isFocused: Bool

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.font = UIFont(name: "PlusJakartaSans-Regular", size: 18)
        textView.backgroundColor = .clear
        textView.textColor = UIColor.black
        textView.delegate = context.coordinator
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        
        // set focus
        if isFocused && !uiView.isFirstResponder {
            uiView.becomeFirstResponder()
        } else if !isFocused && uiView.isFirstResponder {
            uiView.resignFirstResponder()
        }
        
        DynamicTextEditor.recalculateHeight(view: uiView, result: $dynamicHeight)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, height: $dynamicHeight, isFocused: $isFocused)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        var height: Binding<CGFloat>
        var isFocused: Binding<Bool>

        init(text: Binding<String>, height: Binding<CGFloat>, isFocused: Binding<Bool>) {
            self.text = text
            self.height = height
            self.isFocused = isFocused
        }

        func textViewDidChange(_ textView: UITextView) {
            text.wrappedValue = textView.text
            DynamicTextEditor.recalculateHeight(view: textView, result: height)
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.isFocused.wrappedValue = true
            }
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.isFocused.wrappedValue = false
            }
        }
    }

    static func recalculateHeight(view: UIView, result: Binding<CGFloat>) {
        let newSize = view.sizeThatFits(CGSize(width: view.bounds.width, height: .greatestFiniteMagnitude))
        DispatchQueue.main.async {
            if newSize.height <= 120 {
                result.wrappedValue = newSize.height
            }
        }
    }
}
