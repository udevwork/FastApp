import Foundation
import UIKit

final class Haptic {
    static func impact(style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    static func notify(style: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(style)
    }
    static func selection() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
    
    
    func sdf (){
        
        Haptic.impact()
        Haptic.impact(style: .heavy)
        Haptic.notify(style: .success)
        Haptic.selection()
        
        
    }
    
}
