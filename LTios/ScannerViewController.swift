//
//  ScannerViewController.swift
//  LTios
//
//  Created by antoine beneteau on 2017-07-31.
//  Copyright © 2017 Tastyapp. All rights reserved.
//

import UIKit
import SpriteKit
import Spring

class ScannerViewController: UIViewController {
    
    var users = [String]()
    
    var bubbles = [UIView]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        users = ["Hacker","Antoine","Paul"]

        view.setNeedsUpdateConstraints()
        
        for i in 0..<users.count {
            addBubble(picture: #imageLiteral(resourceName: "profilePicture"), mutualFriends: 3, id: i)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let nearbyUser = NearbyUser(uid: "ZADZD", publicName: "Hacker", pushID: "DZAIDAZD")
        
        let node = Node(image: #imageLiteral(resourceName: "profilePicture"), radius: 80, nearbyUser: nearbyUser)
        
        //magnetic?.addChild(node)
        
    }
    
    
    func addBubble(picture: UIImage, mutualFriends: Int, id: Int) {
        
        let bubble = UIView()
        let button = UIButton()
        
        let profilePictureView = roundedImageView()
        
        profilePictureView.image = picture
        profilePictureView.contentMode = .scaleAspectFill
        
        button.addTarget(self, action: #selector(didTouchBubble), for: .touchUpInside)
        
        let bubbleHeight: CGFloat = CGFloat(arc4random_uniform(130 - 110) + 130)
        
        let rand_x = arc4random_uniform(UInt32((view.frame.width - bubbleHeight - 15) - (15))) + 15 // arc4random_uniform(upper - lower) + lower
        let rand_y = arc4random_uniform(UInt32((view.frame.height - bubbleHeight - 100) - (110))) + 110
        
        // bubble = UIView(frame: CGRect(x: CGFloat(rand_x), y: CGFloat(rand_y), width: bubbleHeight, height: bubbleHeight))
        
        for bubblePlaced in bubbles {
            if isRidingABubble(bubble1Frame: CGRect(x: CGFloat(rand_x), y: CGFloat(rand_y), width: bubbleHeight, height: bubbleHeight), bubble2Frame: bubblePlaced.frame) {
                addBubble(picture: picture, mutualFriends: mutualFriends, id: id)
                return
            }
        }
        
        bubble.tag = id
        button.tag = id
        
        bubble.addSubview(profilePictureView)
        bubble.addSubview(button)
        
        view.addSubview(bubble)
        
        bubble.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(bubbleHeight)
            make.height.equalTo(bubbleHeight)
            make.left.equalTo(CGFloat(rand_x))
            make.top.equalTo(CGFloat(rand_y))
        }
        profilePictureView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(bubble)
            make.height.equalTo(bubble)
            make.center.equalTo(bubble.snp.center)
        }
        button.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(bubble)
            make.height.equalTo(bubble)
            make.center.equalTo(bubble.snp.center)
        }
        
        bubbles.append(bubble)
        
        view.layoutIfNeeded()
        
    }

    func isRidingABubble(bubble1Frame: CGRect, bubble2Frame: CGRect) -> Bool {
        
        if (CGRect(x: bubble1Frame.origin.x - 10, y: bubble1Frame.origin.y - 10, width: bubble1Frame.width + 20, height: bubble1Frame.height + 20).intersects(bubble2Frame)) {
            
            return true
        }
        return false
    }
    
    @objc func didTouchBubble(sender: UIView) {
        print("Selected: \(users[sender.tag]) (\(sender.tag))")
        
        let vc = UserProfileViewController()
        
        vc.allowedDismissDirection = dismissDirection(rawValue: 0)!
        vc.directionLock = true
        vc.maskType = InteractiveMaskType(rawValue: UInt(0))!
        vc.userNameLabel.text = users[sender.tag]
        vc.showInteractive()
        
    }
    
    override func updateViewConstraints() {
        
        
        super.updateViewConstraints()

    }
}

class CurvedView: UIView {
    
    override func draw(_ rect: CGRect) {
        
        let y:CGFloat = 20
        let curveTo:CGFloat = 0
        
        let myBezier = UIBezierPath()
        myBezier.move(to: CGPoint(x: 0, y: y))
        myBezier.addQuadCurve(to: CGPoint(x: rect.width, y: y), controlPoint: CGPoint(x: rect.width / 2, y: curveTo))
        myBezier.addLine(to: CGPoint(x: rect.width, y: rect.height))
        myBezier.addLine(to: CGPoint(x: 0, y: rect.height))
        myBezier.close()
        let context = UIGraphicsGetCurrentContext()
        context!.setLineWidth(4.0)
        UIColor.white.setFill()
        myBezier.fill()
    }
}

extension UIView {
    
    func addTopRoundedCornerToView(targetView:UIView?, desiredCurve:CGFloat?) {
        let offset:CGFloat =  targetView!.frame.width/desiredCurve!
        let bounds: CGRect = targetView!.bounds
        
        let rectBounds: CGRect = CGRect(x:bounds.origin.x, y:bounds.origin.y+bounds.size.height / 2, width:bounds.size.width, height:bounds.size.height / 2)
        
        let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
        let ovalBounds: CGRect = CGRect(x:bounds.origin.x - offset / 2, y:bounds.origin.y, width:bounds.size.width + offset, height:bounds.size.height)
        let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        // Create the shape layer and set its path
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.name = "curvedTopLayer"
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        
        // Set the newly created shape layer as the mask for the view's layer
        targetView!.layer.mask = maskLayer
    }
}


