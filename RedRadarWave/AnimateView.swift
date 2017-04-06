

import UIKit

class AnimateView: UIView ,CAAnimationDelegate {

//    var _layer:CALayer!
    var animationGroup:CAAnimationGroup!
    var displayLink:CADisplayLink?
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.displayLink = CADisplayLink(target: self, selector: #selector(self.displayLinkFunc))
        self.displayLink?.preferredFramesPerSecond = 3
        self.displayLink?.add(to: RunLoop.current, forMode: .defaultRunLoopMode)
    }

    func displayLinkFunc(){
   
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = 0.0
        scaleAnimation.toValue   = 1.0
        scaleAnimation.duration  = 2
        scaleAnimation.isRemovedOnCompletion = true
        
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = 2
        opacityAnimation.values = [1,0.5,0.3,0]
        opacityAnimation.keyTimes = [0,0.3,0.6,1]
        opacityAnimation.isRemovedOnCompletion = true
        
        
        self.animationGroup = CAAnimationGroup()
        self.animationGroup.duration = 2
        self.animationGroup.isRemovedOnCompletion = false
        self.animationGroup.fillMode = kCAFillModeForwards
        self.animationGroup.delegate = self
        self.animationGroup.animations = [scaleAnimation,opacityAnimation]
        
        let _layer = CALayer()
        _layer.cornerRadius = self.bounds
        .width/2
        _layer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.width)
        _layer.backgroundColor = UIColor.red.cgColor
        _layer.add(self.animationGroup, forKey: nil)
        self.layer.addSublayer(_layer)
        self.perform(#selector(self.removeLayer(_:)), with: _layer, afterDelay: 2)
    }
    func removeLayer(_ layer:CALayer){

        layer.removeFromSuperlayer()
        
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
//        print("----animation did stop----")
    }
    deinit {
        self.layer.removeAllAnimations()
        self.displayLink?.invalidate()
        print("-------动态annotation deinit")
    }
    
}
