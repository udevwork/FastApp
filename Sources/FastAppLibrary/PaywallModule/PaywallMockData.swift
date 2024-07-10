import RevenueCat

extension PaywallProductItemModel {
    static var mock: [PaywallProductItemModel] = [
        .init(id: "0",
              numereticPrice: 0,
              product: StoreProduct(sk1Product: SK1Product()),
              title: "Year subscription",
              subtitle: "full accsess for a year",
              subscriptionPeriod: "1 Year",
              price: "39,99 $",
              bestValue: true,
              introductoryPeriod: nil,
              offPersent: nil),
        
        .init(id: "1",
              numereticPrice: 1,
              product: StoreProduct(sk1Product: SK1Product()),
              title: "Month subscription",
              subtitle: "full accsess for a month",
              subscriptionPeriod: "1 Month",
              price: "19,99 $",
              bestValue: false,
              introductoryPeriod: "3 days",
              offPersent: nil),
        
        .init(id: "2",
              numereticPrice: 2,
              product: StoreProduct(sk1Product: SK1Product()),
              title: "Week subscription",
              subtitle: "full accsess for a week",
              subscriptionPeriod: "1 Week",
              price: "5,99 $",
              bestValue: false,
              introductoryPeriod: nil,
              offPersent: nil)
    ]
}

extension PaywallBenefitItem {
    public static var mock: [PaywallBenefitItem] = [
        .init(systemIcon: "message.circle.fill",
              title: "Exclusive workouts",
              subtitle: "Access to exclusive workouts"),
        
        .init(systemIcon: "circle.hexagongrid.circle.fill",
              title: "Personalized meal",
              subtitle: "Personalized meal plans for you and famaly"),
        
        .init(systemIcon: "mic.circle.fill",
              title: "Support",
              subtitle: "24/7 expert support")
    ]
}
