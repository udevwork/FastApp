import SwiftUI

public struct OnBoardingModel {
    let image: String
    let title: String
    let subTitle: String
    
    public init(image: String, title: String, subTitle: String) {
        self.image = image
        self.title = title
        self.subTitle = subTitle
    }
}

public struct OnboardingHorizontalGalleryView: View {
        
    @State private var currentStep = 0
    @Environment(\.dismiss) var dismiss

    init() {

    }
    
    let datas = FastApp.shared.settings?.onboardingItems ?? []
    
    public var body: some View {
        VStack(alignment:.center, spacing: 2) {
            TabView(selection: $currentStep) {
                ForEach(0..<datas.count, id: \.self) { index in
                    VStack(spacing: 50) {
                        
                        loadImage(named: datas[index].image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: 320)
                            .clipShape(Rectangle())
                        
                        
                        VStack(spacing: 10) {
                            Text(datas[index].title)
                                .titleStyle()
                          
                            Text(datas[index].subTitle)
                                .bodyStyle()
                        }
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        Spacer()
                    }
                    .tag(index)
                    .edgesIgnoringSafeArea(.top)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            VStack(alignment: .center, spacing: 20, content: {
                
                VStack(alignment: .center, spacing: 5, content: {
                    Image(systemName: "lock.shield.fill")
                        .foregroundStyle(.blue)
                        .opacity(0.7)
                    Text("By using this app, you agree to the").footnoteStyle()
                        .foregroundStyle(.gray)
                        .padding(.horizontal, 50)
                        .multilineTextAlignment(.center)
                    DocumentsButtonsView().font(.footnote)
                })
                
                
                
                Button(action: {
                    if currentStep == datas.count - 1 {
                        dismiss()
                    } else if currentStep < datas.count - 1 {
                        withAnimation {
                            currentStep += 1
                        }
                    }
                }) {
                    Text(
                        currentStep == datas.count - 1
                        ? "Finish" : "Continue"
                    )
                }
                .buttonStyle(LargeButtonStyle())
                .withHapticFeedback()
                .padding(.horizontal, 50)
                
   
                    Button(action: {
                        dismiss()
                    }) {
                        
                        Text("Skip")
                        
                    }
                    .withHapticFeedback()
                    .padding(.horizontal, 50)
                
            })
        }.edgesIgnoringSafeArea(.top)
    }
    
    func loadImage(named name: String) -> Image {
        // Сначала пытаемся найти изображение в основном Bundle
        if let uiImage = UIImage(named: name, in: .main, compatibleWith: nil) {
            return Image(uiImage: uiImage)
        }
        
        // Если не нашли, пытаемся найти изображение в пакете (Bundle.module)
        if let uiImage = UIImage(named: name, in: .module, compatibleWith: nil) {
            return Image(uiImage: uiImage)
        }
        
        // Если не нашли ни там, ни там, возвращаем nil
        return Image("")
    }
    
}


#Preview {
    OnboardingHorizontalGalleryView()
}
