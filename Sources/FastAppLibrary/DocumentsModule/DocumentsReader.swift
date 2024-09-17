import Foundation
import SwiftUI
import MarkdownUI

public class Documents {
    
    public enum documents: String {
        case terms = "Terms of Use"
        case privacy = "Privacy Policy"
    }
    
    public init() {
        
    }
    
    var setting = {
        if let settings = FastApp.shared.settings {
            return settings
        } else {
            return FastAppSettings(
                appName: "TESTNAME",
                companyName: "TEST COMPANY",
                companyEmail: "test@email.com",
                revenueCatAPI: "",
                paywallBenefits: [],
                onboardingItems: [],
                END_USER_LICENSE_AGREEMENT_URL: "",
                PRIVACY_POLICY_LINK: "",
                TERMS_CONDITIONS_LINK: ""
            )
        }
    }()
    
    public func get(documents: documents) -> String {
        var rawtext = readTextFromFile(documents.rawValue, fileType: "txt") ?? ""
        rawtext = rawtext.replacingOccurrences(of: "[App Name]"    , with: setting.appName)
        rawtext = rawtext.replacingOccurrences(of: "[Company Name]", with: setting.companyName)
        rawtext = rawtext.replacingOccurrences(of: "[email]"       , with: setting.companyEmail)
        return rawtext
    }
    
    private func readTextFromFile(_ fileName: String, fileType: String) -> String? {
        guard let path = Bundle.module.path(forResource: fileName, ofType: fileType) else {
            return nil
        }
        
        do {
            let text = try String(contentsOfFile: path, encoding: .utf8)
            return text
        } catch {
            print("Ошибка при чтении файла: \(error)")
            return nil
        }
    }
    
}

public struct DocumentsButtonsView: View {
    
    @State var showTerms : Bool = false
    @State var showPrivacy : Bool = false
    
    public var body: some View {
        HStack(spacing: 0) {
            
            Link("Terms of Use", destination: URL(string: FastApp.shared.settings?.TERMS_CONDITIONS_LINK ?? "")!)
                .foregroundColor(.blue)
                .underline()
            Text(", ")
            Link("Privacy Policy", destination: URL(string: FastApp.shared.settings?.PRIVACY_POLICY_LINK ?? "")!)
                .foregroundColor(.blue)
                .underline()
            Text(", ")
            Link("License", destination: URL(string: FastApp.shared.settings?.PRIVACY_POLICY_LINK ?? "")!)
                .foregroundColor(.blue)
                .underline()
        }.fullScreenCover(isPresented: $showTerms, content: {
            DocumentsView(text: Documents().get(documents: .terms))
        }).fullScreenCover(isPresented: $showPrivacy, content: {
            DocumentsView(text: Documents().get(documents: .privacy))
        })
    }
}

public struct DocumentsView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var text : String
    
    public init(text: String) {
        self.text = text
    }
    
    public var body: some View {
        ZStack {
            ScrollView {
                Markdown(text)
                    .markdownTextStyle(textStyle: {
                        ForegroundColor(.black)
                    })
                    .padding()
                
            }
            .background(.white)
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark.circle.fill").font(.system(size: 30))
                            .shadow(color: .black.opacity(0.5), radius: 15, x: 0, y: 10)
                            .foregroundStyle(Color.black)
                    })
                }.padding(.horizontal,30)
                Spacer()
            }
        }
        
    }
}

#Preview {
    DocumentsButtonsView()
}

