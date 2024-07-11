import SwiftUI

struct SwiftUIView: View {
    
    @State var showingOnboarding: Bool = false
    @State var isFinished: Bool = false
    
    var body: some View {
        VStack(alignment: .leading ,spacing: 15) {
            Spacer()
            Button(action: {
                FastApp.alerts.show(title: "alerts", displayMode: .hud, type: .loading, sdubTitle: "subloading")
            }, label: {
                Text("Show loading")
            })
            
            Button(action: {
                FastApp.alerts.show(title: "alerts", displayMode: .alert, type: .loading, sdubTitle: "subloading")
            }, label: {
                Text("Show more loading")
            })
            
            Button(action: {
                FastApp.alerts.show(title: "alerts", displayMode:.alert, type: .complete(.purple), sdubTitle: "subloading")
            }, label: {
                Text("Show complete")
            })
        }
    }
}

#Preview {
    SwiftUIView().fastAppDefaultWrapper()
}
