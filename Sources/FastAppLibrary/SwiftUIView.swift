//
//  SwiftUIView.swift
//  
//
//  Created by Denis Kotelnikov on 09.07.2024.
//

import SwiftUI

struct SwiftUIView: View {
    
    @State var showingOnboarding: Bool = false
    @State var isFinished: Bool = false
    
    var body: some View {
        VStack(alignment: .leading ,spacing: 15) {
            Spacer()
            Button(action: {
                FastApp.alerts.show(title: "fuck", displayMode: .hud, type: .loading, sdubTitle: "subloading")
            }, label: {
                Text("Show loading")
            })
            
            Button(action: {
                FastApp.alerts.show(title: "fuck", displayMode: .alert, type: .loading, sdubTitle: "subloading")
            }, label: {
                Text("Show more loading")
            })
            
            Button(action: {
                FastApp.alerts.show(title: "fuck", displayMode:.alert, type: .complete(.purple), sdubTitle: "subloading")
            }, label: {
                Text("Show complete")
            })
        }
    }
}

#Preview {
    SwiftUIView().fastAppDefaultWrapper()
}
