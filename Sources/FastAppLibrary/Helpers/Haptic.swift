import Foundation
import UIKit

final public class Haptic {
    static public func impact(style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    static public func notify(style: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(style)
    }
    static public func selection() {
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
