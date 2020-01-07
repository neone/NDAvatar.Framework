//
//  AvatarViewController.swift
//  AvatarImageView
//
//  Created by Dave Glassco on 1/5/20.
//

import UIKit


public struct AvatarViewData {
    public var displayName: String
    var initials: String?
    public var avatarString: String?
    var isRound: Bool?
    var cornerRoundness: CGFloat?
    var borderWidth: CGFloat?
    var borderColor: UIColor?
    var backgroundColor: UIColor?
    
    public init(displayName: String, initials: String? = nil, avatarString: String? = nil, isRound: Bool? = nil, cornerRoundness: CGFloat? = nil, borderWidth: CGFloat? = nil, borderColor: UIColor? = nil, backgroundColor: UIColor? = nil) {
        self.displayName = displayName
        self.initials = initials
        self.avatarString = avatarString
        self.isRound = isRound
        self.cornerRoundness = cornerRoundness
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.backgroundColor = backgroundColor
    }
}

@IBDesignable
public class AvatarViewController: UIView {
    
    public var avatarViewData: AvatarViewData?
    var avatarView: UIView!
    var avatarFrame: UIViewX!
    public var avatarImageView: AvatarImageView!
    
    @IBInspectable public var profileImage: UIImage? {
        didSet {
            if let image = profileImage {
                avatarImageView.image = image
            }
        }
    }
    
    @IBInspectable public var isRound: Bool = false {
        didSet {
            if isRound == true {
                setToRound()
            } else {
                setToDefault()
            }
        }
    }
    
    var currentCorner: CGFloat = 0
    @IBInspectable public var cornerRoundness: CGFloat = 0 {
        didSet {
            avatarFrame.cornerRadius = cornerRoundness
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            avatarFrame.borderWidth = borderWidth
        }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor.white {
        didSet {
            avatarFrame.borderColor = borderColor
        }
    }
    
    //MARK: - Initializers and Overrides
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let avatarSize = frame.height
        
        avatarView = AvatarViewController(frame: CGRect(x: 0, y: 0, width: avatarSize, height: avatarSize))
        self.addSubview(avatarView)
        avatarView.frame = self.bounds
        avatarView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        avatarFrame =  UIViewX(frame: CGRect(x: 0, y: 0, width: avatarSize, height: avatarSize))
        avatarView.addSubview(avatarFrame)
        avatarFrame.frame = self.bounds
        avatarFrame.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        avatarFrame.maskToBounds = true
        
        avatarImageView =  AvatarImageView(frame: CGRect(x: 0, y: 0, width: avatarSize, height: avatarSize))
        avatarFrame.addSubview(avatarImageView)
        avatarImageView.frame = self.bounds
        avatarImageView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        if isRound == true {
            setToRound()
        }
        
    }
    
    public func configureAvatarView(avatarViewData: AvatarViewData) {
        
        var profileName = avatarViewData.displayName
        if let intials = avatarViewData.initials {
            profileName = intials
        }
        avatarImageView.dataSource = AvatarHelper.convertToAvatarData(profileName: profileName, avatarString: avatarViewData.avatarString)
        
        if avatarViewData.isRound == true {
            setToRound()
        }
        
        if let roundness = avatarViewData.cornerRoundness {
            cornerRoundness = roundness
        }
        
        if let border = avatarViewData.borderColor {
            borderColor = border
        }
        
        if let width = avatarViewData.borderWidth {
            borderWidth = width
        }
        
        if let background = avatarViewData.backgroundColor {
            avatarImageView.backgroundColor = background
        }
        
    }
    
    fileprivate func setToRound() {
        currentCorner = avatarFrame.cornerRadius
        avatarFrame.cornerRadius = avatarView.frame.width/2
        configureRoundAvatar()
    }
    
    fileprivate func setToDefault() {
        avatarFrame.cornerRadius = 0
        configureDefaultAvatar()
    }
    
    fileprivate func configureRoundAvatar() {
        struct Config: AvatarImageViewConfiguration { var shape: Shape = .circle }
        avatarImageView.configuration = Config()
    }
    
    fileprivate func configureDefaultAvatar() {
        struct Config: AvatarImageViewConfiguration { var shape: Shape = .square }
        avatarImageView.configuration = Config()
    }
}
