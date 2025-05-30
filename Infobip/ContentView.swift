//
//  ContentView.swift
//  Infobip
//
//  Created by Anouar El Maaroufi on 26/5/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: ChatScreen()) {
                Text("Go To Chat")
            }
        }
    }
}
