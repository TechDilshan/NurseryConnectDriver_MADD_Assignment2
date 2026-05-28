import SwiftUI

#if os(macOS)
import AppKit
#endif

extension Color {
    static var appGroupedBackground: Color {
        #if os(macOS)
        return Color(nsColor: .windowBackgroundColor)
        #else
        return Color(.systemGroupedBackground)
        #endif
    }

    static var appCardBackground: Color {
        #if os(macOS)
        return Color(nsColor: .controlBackgroundColor)
        #else
        return Color(.systemBackground)
        #endif
    }

    static var appSecondaryBackground: Color {
        #if os(macOS)
        return Color(nsColor: .underPageBackgroundColor)
        #else
        return Color(.secondarySystemBackground)
        #endif
    }
}

extension Double {
    var kilometerText: String {
        String(format: "%.2f km", self)
    }

    var percentageText: String {
        "\(Int(self * 100))%"
    }
}

extension String {
    var trimmedText: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var isBlank: Bool {
        trimmedText.isEmpty
    }
}
