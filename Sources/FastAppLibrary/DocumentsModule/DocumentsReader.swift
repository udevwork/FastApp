//
//  File.swift
//  
//
//  Created by Denis Kotelnikov on 09.07.2024.
//

import Foundation
import SwiftUI
import MarkdownUI

public class Documents {
    
    public enum documents: String {
        case terms = "Terms of Use"
        case privacy = "Privacy Policy"
    }
    
    var setting = {
        if let settings = FastApp.shared.settings {
            return settings
        } else {
            return FastAppSettings(appName: "TESTNAME", 
                                   companyName: "TEST COMPANY",
                                   companyEmail: "test@email.com",
                                   reveueCatAPI: "",
                                   paywallBenefits: [],
                                   onboardingItems: [])
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

struct DocumentsButtonsView: View {
    
    @State var showTerms : Bool = false
    @State var showPrivacy : Bool = false
    
    var body: some View {
        HStack {
            Button(action: {
                showTerms.toggle()
            }) {
                Text("Terms of Use")
                    .foregroundColor(.blue)
                    .underline()
            }
            Text("and")
            Button(action: {
                showPrivacy.toggle()
            }) {
                Text("Privacy Policy")
                    .foregroundColor(.blue)
                    .underline()
            }
        }.fullScreenCover(isPresented: $showTerms, content: {
            DocumentsView(text: Documents().get(documents: .terms))
        }).fullScreenCover(isPresented: $showPrivacy, content: {
            DocumentsView(text: Documents().get(documents: .privacy))
        })
    }
}

struct DocumentsView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var text : String
    
    var body: some View {
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

