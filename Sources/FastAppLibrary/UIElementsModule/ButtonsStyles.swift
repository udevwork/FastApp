import SwiftUI

struct LargeButtonStyle: ButtonStyle {
    
    private var buttonColor: AppColor
    
    init(color: AppColor = .primary) {
        self.buttonColor = color
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.white)
            .frame(maxWidth: .infinity, maxHeight: 50)
            .frame(height: 50)
            .background(buttonColor.color)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
            .bold()
    }
}

struct HapticModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(TapGesture().onEnded {
                Haptic.impact()
            })
    }
}

extension View {
    func withHapticFeedback() -> some View {
        self.modifier(HapticModifier())
    }
}

