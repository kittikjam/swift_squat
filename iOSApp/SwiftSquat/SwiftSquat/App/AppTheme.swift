import SwiftUI

enum AppTheme {
    static let accent: Color = Color(red: 0.32, green: 0.82, blue: 0.47)
    static let brightAccent: Color = Color(red: 0.45, green: 0.94, blue: 0.55)
    static let canvas: Color = Color(red: 0.97, green: 0.97, blue: 0.95)
    static let ink: Color = Color(red: 0.08, green: 0.09, blue: 0.09)
    static let secondaryInk: Color = Color(red: 0.36, green: 0.38, blue: 0.37)
    static let line: Color = Color.black.opacity(0.1)
}

extension View {
    func sectionLabel() -> some View {
        return self
            .font(.system(size: 12, weight: .semibold, design: .rounded))
            .tracking(1.4)
            .foregroundColor(AppTheme.secondaryInk)
            .textCase(.uppercase)
    }
}