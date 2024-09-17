#if canImport(UIKit)
import UIKit
import AVKit

@available(iOS 14.0, *)
public class LoopingPlayerUIView: UIView {
    
    /// An object that presents the visual contents of a player object
    private var playerLayer = AVPlayerLayer()
    
    /// An object that loops media content using a queue player
    private var playerLooper: AVPlayerLooper?
    
    // file
    public var name: String
    public var ext: String
    public var gravity: AVLayerVideoGravity
    public var onAnimationFinish: ()->() = { }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// - Parameters:
    ///   - name: Name of the video to play
    ///   - ext: Video extension
    ///   - gravity: A structure that defines how a layer displays a player’s visual content within the layer’s bounds
    public init?(_ name: String, width ext: String, gravity: AVLayerVideoGravity) {
        
        self.name = name
        self.ext = ext
        self.gravity = gravity
        
        /// Load the resource
        guard let fileUrl = Bundle.main.url(forResource: name, withExtension: ext) else{
            return nil
        }
        
        let asset = AVAsset(url: fileUrl)
        
        let item = AVPlayerItem(asset: asset)
        
        /// Setup the player
        let player = AVQueuePlayer()
        player.isMuted = true
        playerLayer.player = player
        playerLayer.videoGravity = gravity
        playerLayer.backgroundColor = UIColor.clear.cgColor
        
        super.init(frame: CGRect.zero)
        
        /// Create a new player looper with the queue player and template item
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
        
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(playerDidFinishPlaying),
                         name: .AVPlayerItemDidPlayToEndTime,
                         object: player.currentItem
            )
        
        /// Start the movie
        player.play()
        
        layer.addSublayer(playerLayer)
    }
    
    public func replace(name: String) {
        /// Load the resource
        guard let fileUrl = Bundle.main.url(forResource: name, withExtension: ext) else{
            return
        }
        
        CATransaction.begin()
        CATransaction.setDisableActions(true) // Отключаем анимацию смены слоя
        
        let asset = AVAsset(url: fileUrl)
        
        let item = AVPlayerItem(asset: asset)
        
        /// Setup the player
        let player = AVQueuePlayer()
        player.isMuted = true
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.backgroundColor = UIColor.clear.cgColor
        
        /// Create a new player looper with the queue player and template item
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
        
        
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(playerDidFinishPlaying),
                         name: .AVPlayerItemDidPlayToEndTime,
                         object: player.currentItem
            )
        
        /// Start the movie
        player.play()
        // Завершаем транзакцию
        CATransaction.commit()
        //  layer.addSublayer(playerLayer)
        
    }
    
    @objc func playerDidFinishPlaying(notification: Notification) {
        onAnimationFinish()
    }
    
    /// override point. called by layoutIfNeeded automatically. As of iOS 6.0, when constraints-based layout is used the base implementation applies the constraints-based layout, otherwise it does nothing.
    public override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}
#endif
