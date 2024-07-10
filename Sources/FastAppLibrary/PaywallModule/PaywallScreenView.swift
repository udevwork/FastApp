import SwiftUI
import RevenueCat
import AlertToast

class PaywallViewModel: ObservableObject {
    
    @Published var selectedPlanIndex: Int = 0
    @Published var products: [PaywallProductItemModel] = PaywallProductItemModel.mock
    @Published var benefits: [PaywallBenefitItem] = FastApp.shared.settings?.paywallBenefits ?? PaywallBenefitItem.mock
    
    var productsCount: Int = 0
    
    init() {
        getSubscriptions()
    }
    
    func getSubscriptions() {
        FastApp.subscriptions.getOffer { products in
            self.productsCount = products.count
            products.forEach { product in
                
                guard let period = product.subscriptionPeriod else { return }
                
                var productModel = PaywallProductItemModel(
                    id: product.productIdentifier,
                    numereticPrice: product.price,
                    product: product,
                    title: product.localizedTitle,
                    subtitle: product.localizedDescription,
                    subscriptionPeriod: "\(period.value) \(period.unit)",
                    price: product.localizedPriceString,
                    bestValue: period.unit == .year
                )
                
                FastApp.subscriptions.checkForTrial(product: product) { eligibility in
                    if eligibility == .eligible {
                        if let trial = product.introductoryDiscount?.subscriptionPeriod {
                            productModel.introductoryPeriod = "\(trial.value) \(trial.unit)"
                        }
                    } else if eligibility == .ineligible {
                        productModel.introductoryPeriod = "ineligible"
                    }
                    DispatchQueue.main.async {
                        self.products.append(productModel)
                        if self.products.count == self.productsCount {
                            self.products = self.products.sorted(by: {
                                $0.numereticPrice > $1.numereticPrice
                            })
                        }
                    }
                }
            }
        }
    }
    
    func subscribe() {
        FastApp.subscriptions.subscribe(product: self.products[selectedPlanIndex].product)
    }
    
    func restorePurchases(){
        FastApp.subscriptions.restorePurchases()
    }
    
    func openTerms(){
        let doc = Documents()
        print(doc)
    }
}

public struct PaywallUIView: View {
    
    @StateObject var model = PaywallViewModel()
 
    private let trialWarningText = "The free trial lasts for 3 days, after which your subscription will automatically renew at the selected plan's price unless canceled at least 24 hours before the end of the trial period."
    
    public init() {
        
    }
    
    public var body: some View {
        NavigationStack {
            
            ZStack {
                ScrollView {
                    if model.products.isEmpty == false {
                        VStack(spacing: 30) {
                            
                            VStack(alignment: .leading) {
                                Text("Benefits")
                                VStack(spacing:16) {
                                    ForEach(model.benefits) { item in
                                        PaywallBenefitItemView(item: item)
                                            .transition(.opacity)
                                    }
                                }
                                .padding()
                                .background(Color.adaptiveBlackWhite)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 20)
                                )
                            }
                           
                            VStack(alignment: .leading) {
                                Text("Pick up subscription plan")
                                ForEach(model.products.indices, id: \.self) { i in
                                    Button(action: {
                                        withAnimation {
                                            model.selectedPlanIndex = i
                                        }
                                    }, label: {
                                        PaywallProductElementView(product: model.products[i], selected: i == model.selectedPlanIndex)
                                            .foregroundStyle(Color.label)
                                    }).withHapticFeedback()
                                    
                                }
                            }
                           
                            Rectangle().foregroundStyle(.clear)
                                .frame(height: 200)
                           
                        }.padding(.horizontal, 20)
                    }
                }
                
                VStack {
                    Spacer()
                    VStack(spacing: 10) {
                        
                        Button(action: {
                            model.subscribe()
                        }, label: {
                            let text = model.products[model.selectedPlanIndex].title.uppercased()
                            Text("GET \(text)")
                        })
                        .buttonStyle(LargeButtonStyle())
                        .withHapticFeedback()
                        
                        Button(action: {
                            model.restorePurchases()
                        }) {
                            Text("Restore purchases")
                                .foregroundColor(.green)
                                .bold()
                                .underline()
                        }
                        .withHapticFeedback()
                        
                        Text(trialWarningText).footnoteStyle()
                        
                        DocumentsButtonsView()
                        
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                }
            }
            .navigationTitle("Go premuim!")
            .background(Color.systemGray6)
      
        }
    }
}

#Preview {
    PaywallUIView().fastAppDefaultWrapper()
}
