import Foundation
import SwiftUI

extension Color {
    
    static let systemRed = Color(UIColor.systemRed)
    static let systemGreen = Color(UIColor.systemGreen)
    static let systemBlue = Color(UIColor.systemBlue)
    static let systemOrange = Color(UIColor.systemOrange)
    static let systemYellow = Color(UIColor.systemYellow)
    static let systemPink = Color(UIColor.systemPink)
    static let systemPurple = Color(UIColor.systemPurple)
    static let systemTeal = Color(UIColor.systemTeal)
    static let systemIndigo = Color(UIColor.systemIndigo)
    static let label = Color(UIColor.label)
    static let secondaryLabel = Color(UIColor.secondaryLabel)
    static let tertiaryLabel = Color(UIColor.tertiaryLabel)
    static let quaternaryLabel = Color(UIColor.quaternaryLabel)
    static let systemFill = Color(UIColor.systemFill)
    static let secondarySystemFill = Color(UIColor.secondarySystemFill)
    static let tertiarySystemFill = Color(UIColor.tertiarySystemFill)
    static let quaternarySystemFill = Color(UIColor.quaternarySystemFill)
    static let placeholderText = Color(UIColor.placeholderText)
    static let systemBackground = Color(UIColor.systemBackground)
    static let secondarySystemBackground = Color(UIColor.secondarySystemBackground)
    static let tertiarySystemBackground = Color(UIColor.tertiarySystemBackground)
    static let systemGroupedBackground = Color(UIColor.systemGroupedBackground)
    static let secondarySystemGroupedBackground = Color(UIColor.secondarySystemGroupedBackground)
    static let tertiarySystemGroupedBackground = Color(UIColor.tertiarySystemGroupedBackground)
    static let separator = Color(UIColor.separator)
    static let opaqueSeparator = Color(UIColor.opaqueSeparator)
    static let link = Color(UIColor.link)
    static let darkText = Color(UIColor.darkText)
    static let lightText = Color(UIColor.lightText)
    static let systemGray = Color(UIColor.systemGray)
    static let systemGray2 = Color(UIColor.systemGray2)
    static let systemGray3 = Color(UIColor.systemGray3)
    static let systemGray4 = Color(UIColor.systemGray4)
    static let systemGray5 = Color(UIColor.systemGray5)
    static let systemGray6 = Color(UIColor.systemGray6)
    
    static var adaptiveBlackWhite: Color {
        Color(UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? UIColor.systemGray5 : UIColor.white
        })
    }
}

enum AppColor {
    case error
    case success
    case primary
    case warning
    case info
    case highlight
    case background
    case accent
    case secondary
    case label
    case invertLabel
    
    var color: Color {
        switch self {
            case .error:
                return .systemRed
            case .success:
                return .systemGreen
            case .primary:
                return .systemBlue
            case .warning:
                return .systemOrange
            case .info:
                return .systemYellow
            case .highlight:
                return .systemPink
            case .background:
                return .systemPurple
            case .accent:
                return .systemTeal
            case .secondary:
                return .systemIndigo
            case .label:
                return .label
            case .invertLabel:
                return .darkText
        }
    }
}

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("systemRed").foregroundStyle(Color.systemRed)
                Text("systemGreen").foregroundStyle(Color.systemGreen)
                Text("systemBlue").foregroundStyle(Color.systemBlue)
                Text("systemOrange").foregroundStyle(Color.systemOrange)
                Text("systemYellow").foregroundStyle(Color.systemYellow)
                Text("systemPink").foregroundStyle(Color.systemPink)
                Text("systemPurple").foregroundStyle(Color.systemPurple)
                Text("systemTeal").foregroundStyle(Color.systemTeal)
                Text("systemIndigo").foregroundStyle(Color.systemIndigo)
                Text("label").foregroundStyle(Color.label)
                Text("secondaryLabel").foregroundStyle(Color.secondaryLabel)
                Text("tertiaryLabel").foregroundStyle(Color.tertiaryLabel)
                Text("quaternaryLabel").foregroundStyle(Color.quaternaryLabel)
                Text("systemFill").foregroundStyle(Color.systemFill)
                Text("secondarySystemFill").foregroundStyle(Color.secondarySystemFill)
                Text("tertiarySystemFill").foregroundStyle(Color.tertiarySystemFill)
                Text("quaternarySystemFill").foregroundStyle(Color.quaternarySystemFill)
                Text("placeholderText").foregroundStyle(Color.placeholderText)
                Text("systemBackground").foregroundStyle(Color.systemBackground)
                Text("secondarySystemBackground").foregroundStyle(Color.secondarySystemBackground)
                Text("tertiarySystemBackground").foregroundStyle(Color.tertiarySystemBackground)
                Text("systemGroupedBackground").foregroundStyle(Color.systemGroupedBackground)
                Text("secondarySystemGroupedBackground").foregroundStyle(Color.secondarySystemGroupedBackground)
                Text("tertiarySystemGroupedBackground").foregroundStyle(Color.tertiarySystemGroupedBackground)
                Text("separator").foregroundStyle(Color.separator)
                Text("opaqueSeparator").foregroundStyle(Color.opaqueSeparator)
                Text("link").foregroundStyle(Color.link)
                Text("darkText").foregroundStyle(Color.darkText)
                Text("lightText").foregroundStyle(Color.lightText)
                Text("systemGray").foregroundStyle(Color.systemGray)
                Text("systemGray2").foregroundStyle(Color.systemGray2)
                Text("systemGray3").foregroundStyle(Color.systemGray3)
                Text("systemGray4").foregroundStyle(Color.systemGray4)
                Text("systemGray5").foregroundStyle(Color.systemGray5)
                Text("systemGray6").foregroundStyle(Color.systemGray6)
            }
            .bold()
            .padding()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
