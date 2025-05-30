//
//  ColorPalette.swift
//  LiveChat.Done
//
//  Created by Anouar El Maaroufi on 26/5/2025.
//

import SwiftUI

extension Color {
    // Primary Colors
    static let primaryLight = Color(hex: 0xAB2F00)
    static let onPrimaryLight = Color.white
    static let primaryContainerLight = Color(hex: 0xD63D00)
    static let onPrimaryContainerLight = Color(hex: 0xFFFBFF)

    // Secondary Colors
    static let secondaryLight = Color(hex: 0x9E4225)
    static let onSecondaryLight = Color.white
    static let secondaryContainerLight = Color(hex: 0xFE8C69)
    static let onSecondaryContainerLight = Color(hex: 0x742409)

    // Tertiary Colors
    static let tertiaryLight = Color(hex: 0x745B00)
    static let onTertiaryLight = Color.white
    static let tertiaryContainerLight = Color(hex: 0xCCA731)
    static let onTertiaryContainerLight = Color(hex: 0x4F3D00)

    // Error Colors
    static let errorLight = Color(hex: 0xBA1A1A)
    static let onErrorLight = Color.white
    static let errorContainerLight = Color(hex: 0xFFDAD6)
    static let onErrorContainerLight = Color(hex: 0x93000A)

    // Background & Surface
    static let backgroundLight = Color(hex: 0xFFF8F6)
    static let onBackgroundLight = Color(hex: 0x271813)
    static let surfaceLight = Color(hex: 0xFFF8F6)
    static let onSurfaceLight = Color(hex: 0x271813)
    static let surfaceVariantLight = Color(hex: 0xFFDBD1)
    static let onSurfaceVariantLight = Color(hex: 0x5B4039)

    // Outline & Variants
    static let outlineLight = Color(hex: 0x8F7067)
    static let outlineVariantLight = Color(hex: 0xE4BEB4)

    // Scrim & Inverse
    static let scrimLight = Color.black
    static let inverseSurfaceLight = Color(hex: 0x3E2C27)
    static let inverseOnSurfaceLight = Color(hex: 0xFFEDE8)
    static let inversePrimaryLight = Color(hex: 0xFFB59F)

    // Surface Elevation Levels
    static let surfaceDimLight = Color(hex: 0xF1D4CC)
    static let surfaceBrightLight = Color(hex: 0xFFF8F6)
    static let surfaceContainerLowestLight = Color.white
    static let surfaceContainerLowLight = Color(hex: 0xFFF1ED)
    static let surfaceContainerLight = Color(hex: 0xFFE9E4)
    static let surfaceContainerHighLight = Color(hex: 0xFFE2DA)
    static let surfaceContainerHighestLight = Color(hex: 0xFADCD4)
}

// Hex initializer
extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}
