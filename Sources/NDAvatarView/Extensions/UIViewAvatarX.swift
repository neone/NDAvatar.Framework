//
//  UIViewAvatarX.swift
//  DesignableX
//
//  Created by Mark Moeykens on 12/31/16.
//  Copyright © 2016 Mark Moeykens. All rights reserved.
//
#if !os(macOS)
import UIKit

@IBDesignable
public class UIViewAvatarX: UIView {
    
    // MARK: - Gradient
    
    @IBInspectable public var firstColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable public var secondColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable public var horizontalGradient: Bool = false {
        didSet {
            updateView()
        }
    }
    
    override public class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
   
    
    @IBInspectable public var background: UIColor = UIColor.clear {
        didSet {
            layer.backgroundColor = background.cgColor
        }
    }
    
    // MARK: - Border
    
    @IBInspectable public var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    /// Corner radius of view; also inspectable from Storyboard.
     @IBInspectable public var maskToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
//    func fadeTo(_ alpha: CGFloat, duration: TimeInterval? = 0.3) {
//        DispatchQueue.main.async {
//            UIView.animate(withDuration: duration != nil ? duration! : 0.3) {
//                self.alpha = alpha
//            }
//        }
//    }
//    
//    func fadeIn(_ duration: TimeInterval? = 0.3) {
//        fadeTo(1.0, duration: duration)
//    }
//    func fadeOut(_ duration: TimeInterval? = 0.3) {
//        fadeTo(0.0, duration: duration)
//    }
    
    func updateView() {
        
        let layer = self.layer as! CAGradientLayer
        layer.colors = [ firstColor.cgColor, secondColor.cgColor ]
        
        if (horizontalGradient) {
            layer.startPoint = CGPoint(x: 0.0, y: 0.5)
            layer.endPoint = CGPoint(x: 1.0, y: 0.5)
        } else {
            layer.startPoint = CGPoint(x: 0, y: 0.0)
            layer.endPoint = CGPoint(x: 0, y: 0.5)
        }
    }
    
}
#endif


