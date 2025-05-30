//
//  ChatTopBar.swift
//  LiveChat.Done
//
//  Created by Omar Makran on 26/5/2025.
  

import SwiftUI

struct ChatTopBar: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        HStack(spacing: 16) {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
                    .font(.system(size: 22, weight: .semibold))
                    .frame(width: 36, height: 36)
            }
            Image("DoneIcon")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 42, height: 42)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.primary.opacity(0.1), lineWidth: 2))
                .shadow(color: Color.black.opacity(0.08), radius: 2, y: 1)
            VStack(alignment: .leading, spacing: 2) {
                Text("Done")
                    .font(.Done.bold(size: 18))
                    .foregroundColor(.black)
                Text("Support")
                    .font(.Done.regular(size: 16))
                    .foregroundColor(.black)
            }
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.top, 20)
        .padding(.bottom, 12)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.05), radius: 2, y: 2)
    }
}

#Preview {
    ChatTopBar()
}
