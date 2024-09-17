import SwiftUI
import UIKit
import AVKit

/// Player view for running a video in loop
@available(iOS 14.0, *)
public struct LoopPlayerView: UIViewRepresentable {
    
    /// Set of settings for video the player
    public let settings : Settings
    public let view: LoopingPlayerUIView
    
    // MARK: - Life circle
    
    /// Player initializer
    /// - Parameters:
    ///   - fileName: Name of the video to play
    ///   - ext: Video extension
    ///   - gravity: A structure that defines how a layer displays a player’s visual content within the layer’s bounds
    
    public init(view: LoopingPlayerUIView) {
        self.view = view
        settings = Settings {
            FileName(view.name)
            Ext(view.ext)
            Gravity(view.gravity)
            ErrorGroup{
                EColor(.accentColor)
                EFontSize(17.0)
            }
        }
    }

    // MARK: - API
    
    /// Inherited from UIViewRepresentable
    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LoopPlayerView>) {
        
    }
        
    /// - Parameter context: Contains details about the current state of the system
    /// - Returns: View
    
    public func makeUIView(context: Context) -> UIView {
        return view
    }
}


// MARK: - Helpers

/// https://stackoverflow.com/questions/12591192/center-text-vertically-in-a-uitextview
fileprivate class ErrorMsgTextView: UITextView {
    override var contentSize: CGSize {
        didSet {
            var top = (bounds.size.height - contentSize.height * zoomScale) / 2.0
            top = max(0, top)
            contentInset = UIEdgeInsets(top: top, left: 0, bottom: 0, right: 0)
        }
    }
}

/// - Returns: Error view
fileprivate func errorTpl(_ error : VPErrors,_ color : Color, _ fontSize: CGFloat) -> ErrorMsgTextView{
    let textView = ErrorMsgTextView()
    textView.backgroundColor = .clear
    textView.text = error.description
    textView.textAlignment = .center
    textView.font = UIFont.systemFont(ofSize: fontSize)
    textView.textColor = UIColor(color)
    return textView
}
