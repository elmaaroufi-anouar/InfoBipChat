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
