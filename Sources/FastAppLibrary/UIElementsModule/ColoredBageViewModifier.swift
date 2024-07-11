import SwiftUI

struct ColoredBageModifier: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .bold()
            .foregroundStyle(color)
            .padding(.horizontal, 12)
            .padding(.vertical, 7)
            .background(color.opacity(0.1))
            .clipShape(
                RoundedRectangle(cornerRadius: 13)
            )
    }
}

extension View {
    func coloredBageStyle(color: Color) -> some View {
        self.modifier(ColoredBageModifier(color: color))
    }
}

#Preview {
    HStack {
        Text("green").coloredBageStyle(color: .green)
        Text("blue").coloredBageStyle(color: .blue)
        Text("red").coloredBageStyle(color: .red)
        Text("purple").coloredBageStyle(color: .purple)
    }
}
