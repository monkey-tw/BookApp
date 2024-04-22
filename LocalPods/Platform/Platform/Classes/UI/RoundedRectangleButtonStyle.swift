import Foundation
import SwiftUI

public struct RoundedRectangleButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    let labelColor: Color
    public init(labelColor: Color = .black) {
        self.labelColor = labelColor
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label.foregroundColor(labelColor)
            Spacer()
        }
        .padding()
        .background(isEnabled ? Color.yellow.cornerRadius(8) : Color.gray.cornerRadius(8))
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
