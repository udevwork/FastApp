import Foundation
import SwiftUI

public struct PaywallBenefitItem: Identifiable {
    
    public var id = UUID()
    var systemIcon: String
    var title: String
    var subtitle: String
    
    public init(systemIcon: String, title: String, subtitle: String) {
        self.systemIcon = systemIcon
        self.title = title
        self.subtitle = subtitle
    }
}

struct PaywallBenefitItemView: View {
    
    var item: PaywallBenefitItem
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: item.systemIcon)
                .font(.system(size: 29))
                .foregroundStyle(.blue)
//                .imageScale(.large)
            VStack(alignment: .leading, spacing: 3) {
                Text(item.title)
                    .bodyStyle()
                    .lineLimit(10)
                    .multilineTextAlignment(.leading)
                Text(item.subtitle)
                    .captionStyle()
                    .lineLimit(10)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(Color.secondaryLabel)
                
            }
            Spacer()
        }
          
          
    }
}
