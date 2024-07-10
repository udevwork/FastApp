import RevenueCat
import Foundation
import SwiftUI

public struct PaywallProductItemModel: Identifiable {
    public var id: String
    var numereticPrice: Decimal
    var product: StoreProduct
    var title: String
    var subtitle: String
    var subscriptionPeriod: String
    var price: String
    var bestValue: Bool
    var introductoryPeriod: String?
    var offPersent: String?
}

struct PaywallProductElementView: View {
    
    var product: PaywallProductItemModel
    var selected: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(product.title)
                            .bodyStyle()
                            .lineLimit(1)
                           
                        Text("\(product.subscriptionPeriod) / \(product.price)".capitalized)
                            .captionStyle()
                            .lineLimit(2)
                            .bold()
                        
                    }
                    Spacer()
                    if let trial = product.introductoryPeriod {
                        HStack(spacing:5) {
                            Text(trial)
                            Text("trial").bold()
                        }.coloredBageStyle(color: .purple)
                    }
                    if product.bestValue {
                        HStack {
                            Image(systemName: "flame.fill")
                            Text("Best!")
                        }.coloredBageStyle(color: .red)
                    }
                }
            }.padding(20)
            Spacer()
        }
        .frame(maxWidth: .infinity)
      
        .background(Color.adaptiveBlackWhite)
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(selected ? .blue : .clear, lineWidth: 2)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )

        .shadow(color: .black.opacity(0.2), radius: selected ? 5 : 0, x: 0, y: 0)
    }
}
