import Foundation
import RevenueCat
import SwiftUI
import AlertToast
import Foil

extension FastApp {
    public class Onboarding: ObservableObject {
        
        @Published
        var showOnboarding: Bool = false
        
        @FoilDefaultStorage(key: "OnboardingComplete")
        var inboardingComplete = false
        
        public func showIfNeeded() {
            if !inboardingComplete {
                showOnboarding = true
                inboardingComplete = true
            }
        }
    }
}

extension FastApp {
    public class Alerts: ObservableObject {
        @Published 
        var showAlert: Bool = false
        var title: String? = nil
        var displayMode: AlertToast.DisplayMode = .alert
        var type: AlertToast.AlertType = .regular
        var subTitle: String? = nil
        var style: AlertToast.AlertStyle? = nil
        
        public func show (
            title: String,
            displayMode: AlertToast.DisplayMode = .alert,
            type: AlertToast.AlertType = .regular,
            sdubTitle: String? = nil,
            style: AlertToast.AlertStyle? = nil
        ) {
            self.title = title
            self.displayMode = displayMode
            self.type = type
            self.subTitle = sdubTitle
            self.style = style
            alerts.showAlert.toggle()
        }
    }
}

extension FastApp {
    public class Subscriptions: ObservableObject {
        
        @Published
        var showPaywall: Bool = false
        
        @Published
        public var isSubscribed: Bool = false
        
        public func showPaywallScreen() {
            showPaywall.toggle()
        }
        
        public func getOffer(_ completion: @escaping ([StoreProduct])->()) {
            guard FastApp.shared.settings != nil else { return }
            Purchases.shared.getOfferings { offering, error in
                if let pachages = offering?.current {
                    completion(pachages.availablePackages.map({
                        $0.storeProduct
                    }).sorted(by: {
                        $0.price > $1.price
                    }))
                }
            }
        }
        
        public func checkForTrial(
            product: StoreProduct,
            completion: @escaping (IntroEligibilityStatus) -> Void
        ){
            guard FastApp.shared.settings != nil else { return }
            Purchases.shared.checkTrialOrIntroDiscountEligibility(product: product, completion: completion)
        }
        
        func restorePurchases() {
            guard FastApp.shared.settings != nil else { return }
            Purchases.shared.restorePurchases { customerInfo, error in
                alerts.show(title: "Purchases restored!")
            }
        }
        
        public func checkSubscriptionStatus() {
            Purchases.shared.getCustomerInfo { customerInfo, error in
                if let error = error {
                    DispatchQueue.main.async {
                        alerts.show(title: error.localizedDescription)
                        self.isSubscribed = false
                    }
                    return
                }
                
                if let customerInfo = customerInfo {
                    let activeEntitlements = customerInfo.entitlements.active
                    DispatchQueue.main.async {
                        self.isSubscribed = !activeEntitlements.isEmpty
                    }
                } else {
                    DispatchQueue.main.async {
                        alerts.show(title: "Failed to retrieve customer info")
                        self.isSubscribed = false
                    }
                }
            }
        }
        
        public func fetchExpirationDate() {
            Purchases.shared.getCustomerInfo { (purchaserInfo, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        alerts.show(title: "\(error.localizedDescription)")
                    }
                    return
                }
                
                if let entitlements = purchaserInfo?.entitlements.active {
                    
                    if entitlements.isEmpty {
                        alerts.show(title: "User not subscribed")
                        return
                    }
                    
                    for (key, entitlement) in entitlements {
                        
                        if let expirationDate = entitlement.expirationDate {
                            DispatchQueue.main.async {
                                let dateFormatter = DateFormatter()
                                dateFormatter.timeZone = TimeZone.current // Установка текущей временной зоны
                                dateFormatter.locale = Locale.current // Установка текущей локали
                                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Формат даты и времени
                                let formatedDate = dateFormatter.string(from: expirationDate)
                                alerts.show(title: "\(key) end: \(formatedDate), \(entitlement.isActive)")
                            }
                        } else {
                            DispatchQueue.main.async {
                                alerts.show(title: "no expiration date")
                            }
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        alerts.show(title: "User not subscribed")
                    }
                }
            }
        }
        
        func subscribe(product: StoreProduct) {
            guard FastApp.shared.settings != nil else { return }
            Purchases.shared.purchase(product: product) { transaction, customerInfo, error, userCancelled in
                if let error = error {
                    DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                        alerts.show(title: error.localizedDescription)
                    })
                    return
                }
                
                if userCancelled {
                    DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                        alerts.show(title: "Cancelled by the user")
                    })
                    return
                }
                
                if let transaction = transaction, let customerInfo = customerInfo {
                    DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                        alerts.show(title: "Purchase successful!")
                        self.isSubscribed = true
                    })
                }
            }
        }
    }
}

public class FastApp: ObservableObject {
    
    public static var shared = FastApp()
    public static var alerts = Alerts()
    public static var subscriptions = Subscriptions()
    public static var onboarding = Onboarding()
    
    var settings: FastAppSettings? = nil
    
    private init() { }
    
    public func setup(_ settings: FastAppSettings){
        self.settings = settings
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: settings.revenueCatAPI)
        FastApp.onboarding.showIfNeeded()
    }
}

public struct FastAppSettings {
    
    public var appName: String
    public var companyName: String
    public var companyEmail: String
    public var revenueCatAPI: String
    public var paywallBenefits: [PaywallBenefitItem]
    public var onboardingItems: [OnBoardingModel]
    
    public init(
        appName: String,
        companyName: String,
        companyEmail: String,
        revenueCatAPI: String,
        paywallBenefits: [PaywallBenefitItem],
        onboardingItems: [OnBoardingModel]
    ) {
        self.appName = appName
        self.companyName = companyName
        self.companyEmail = companyEmail
        self.revenueCatAPI = revenueCatAPI
        self.paywallBenefits = paywallBenefits
        self.onboardingItems = onboardingItems
    }
}

struct DefaultModifier: ViewModifier {
    
    @StateObject
    var subscriptions = FastApp.subscriptions
    
    @StateObject
    var alerts = FastApp.alerts
    
    @StateObject
    var onboarding = FastApp.onboarding
    
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $onboarding.showOnboarding, content: {
                OnboardingHorizontalGalleryView()
            })
            .sheet(isPresented: $subscriptions.showPaywall) {
                PaywallUIView()
            }
            .toast(isPresenting: $alerts.showAlert, alert: {
                return AlertToast(
                    displayMode: alerts.displayMode,
                    type: alerts.type,
                    title: alerts.title,
                    subTitle: alerts.subTitle,
                    style: nil
                )
            })
    }
}

extension View {
    public func fastAppDefaultWrapper() -> some View {
        self.modifier(DefaultModifier())
    }
}
