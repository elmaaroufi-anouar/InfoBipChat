//
//  Typography.swift
//  LiveChat.Done
//
//  Created by Anouar El Maaroufi on 26/5/2025.
//

import SwiftUI

extension Font {
    private static let fontName: String = "PlusJakartaSans"
    struct Done {
        static func light(size: CGFloat) -> Font {
            .custom("\(fontName)-Light", size: size)
        }

        static func regular(size: CGFloat) -> Font {
            .custom("\(fontName)-Regular", size: size)
        }

        static func medium(size: CGFloat) -> Font {
            .custom("\(fontName)-Medium", size: size)
        }

        static func semibold(size: CGFloat) -> Font {
            .custom("\(fontName)-Semibold", size: size)
        }

        static func bold(size: CGFloat) -> Font {
            .custom("\(fontName)-Bold", size: size)
        }
    }
}

extension Font {
    struct App {
        // Display
        static var displayLarge: Font { .Done.bold(size: 57) }
        static var displayMedium: Font { .Done.bold(size: 45) }
        static var displaySmall: Font { .Done.bold(size: 36) }

        // Headline
        static var headlineLarge: Font { .Done.semibold(size: 32) }
        static var headlineMedium: Font { .Done.semibold(size: 28) }
        static var headlineSmall: Font { .Done.semibold(size: 24) }

        // Title
        static var titleLarge: Font { .Done.medium(size: 22) }
        static var titleMedium: Font { .Done.medium(size: 16) }
        static var titleSmall: Font { .Done.medium(size: 14) }

        // Body
        static var bodyLarge: Font { .Done.regular(size: 16) }
        static var bodyMedium: Font { .Done.regular(size: 14) }
        static var bodySmall: Font { .Done.regular(size: 12) }

        // Label
        static var labelLarge: Font { .Done.light(size: 14) }
        static var labelMedium: Font { .Done.light(size: 12) }
        static var labelSmall: Font { .Done.light(size: 11) }
    }
}
