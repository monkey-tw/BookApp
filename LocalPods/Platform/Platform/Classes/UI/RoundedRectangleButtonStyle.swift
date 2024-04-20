import Foundation
import SwiftUI

public struct RoundedRectangleButtonStyle: ButtonStyle {
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
        .background(Color.yellow.cornerRadius(8))
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
