//
//  Menu.swift
//  LTios
//
//  Created by antoine beneteau on 2017-07-20.
//  Copyright © 2017 Tastyapp. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UIScrollViewDelegate {
    
    var didSetupConstraints = false
    
    let statusBarWindow = UIApplication.shared.value(forKey: "statusBarWindow") as? UIWindow
    var statusBarIsDark = Bool()
    
    var currentController = 0
    
    lazy var horizontalScrollView: UIScrollView = {
        let view = UIScrollView()
        view.delegate = self
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.tag = 10
        view.backgroundColor = .clear
        view.bounces = false
        view.contentSize = CGSize(width: 1, height: 1)
        if #available(iOS 11.0, *) {
            view.contentInsetAdjustmentBehavior = .never
        }
        return view
    }()
    
    lazy var verticalScrollView: UIScrollView = {
        let view = UIScrollView()
        view.delegate = self
        view.isPagingEnabled = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.tag = 20
        view.backgroundColor = .green
        view.bounces = false
        if #available(iOS 11.0, *) {
            view.contentInsetAdjustmentBehavior = .never
        }
        return view
    }()
    
    // MARK: ViewControllers
    let addressBookVC = ContactsViewController() // bottom
    let scannerVC = ScannerViewController() // middle (0)
    let nearbyPlacesVC = NearbyPlacesViewController() // right (1)
    let profileVC = ProfileViewController() // left (-1)
    
    
    // MARK: Header
    lazy var titleLabel: TitleLabel = {
        let view = TitleLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Bar du Poissonnier"
        view.textColor = UIColor(red:0.11, green:0.20, blue:0.35, alpha:1.0)
        view.alpha = 1.0
        view.sizeToFit()
        return view
    }()
    
    // MARK: Navigation Menu
    var profileMenuButton = UIButton()
    var homeMenuButton = UIButton()
    var placesMenuButton = UIButton()
    var selectionMenuBar = UIView()
    
    
    var colorEffectView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(horizontalScrollView)
        horizontalScrollView.addSubview(verticalScrollView)
        
        addChildViewController(scannerVC)
        verticalScrollView.addSubview(scannerVC.view)
        scannerVC.didMove(toParentViewController: self)
        
        
        addChildViewController(addressBookVC)
        verticalScrollView.addSubview(addressBookVC.view)
        addressBookVC.didMove(toParentViewController: self)
        
        addChildViewController(nearbyPlacesVC)
        horizontalScrollView.addSubview(nearbyPlacesVC.view)
        nearbyPlacesVC.didMove(toParentViewController: self)
        
        
        addChildViewController(profileVC)
        horizontalScrollView.addSubview(profileVC.view)
        profileVC.didMove(toParentViewController: self)
        
        
        horizontalScrollView.contentOffset = CGPoint(x: view.frame.size.width, y: 0)
        verticalScrollView.contentOffset = CGPoint(x: 0, y: 0)
        horizontalScrollView.contentSize = CGSize(width: view.frame.size.width * 3, height: view.frame.size.height)
        verticalScrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height * 2)
        
        colorEffectView.image = #imageLiteral(resourceName: "background_gradient_center")
        colorEffectView.alpha = 0
        scannerVC.view.addSubview(colorEffectView)
        
        // MARK: Header
        view.addSubview(titleLabel)
        
        // MARK: Navigation Menu
        profileMenuButton.setBackgroundImage(#imageLiteral(resourceName: "menu_profile"), for: .normal)
        homeMenuButton.setBackgroundImage(#imageLiteral(resourceName: "menu_home"), for: .normal)
        placesMenuButton.setBackgroundImage(#imageLiteral(resourceName: "menu_places"), for: .normal)
        
        profileMenuButton.addTarget(self, action: #selector(didTapProfileButton), for: .touchUpInside)
        homeMenuButton.addTarget(self, action: #selector(didTapHomeButton), for: .touchUpInside)
        placesMenuButton.addTarget(self, action: #selector(didTapPlacesButton), for: .touchUpInside)
        
        selectionMenuBar.backgroundColor = UIColor(red:0.11, green:0.20, blue:0.35, alpha:1.0)
        selectionMenuBar.layer.cornerRadius = 6
        
        view.addSubview(profileMenuButton)
        view.addSubview(homeMenuButton)
        view.addSubview(placesMenuButton)
        view.addSubview(selectionMenuBar)
        
        view.setNeedsUpdateConstraints()
                
    }
    
    override func prefersHomeIndicatorAutoHidden() -> Bool {
        return true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layer.layoutIfNeeded()
    }
    
    @objc func didTapProfileButton(sender: UIButton) {
        if currentController != -1 {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.beginFromCurrentState, .curveEaseOut], animations: {
                self.placesMenuButton.snp.updateConstraints { (make) -> Void in
                    make.right.equalTo(self.view.snp.right).offset(-100)
                }
                self.profileMenuButton.snp.updateConstraints { (make) -> Void in
                    make.left.equalTo(self.view.snp.left).offset(100)
                }
                self.selectionMenuBar.snp.remakeConstraints { (make) -> Void in
                    make.height.equalTo(10)
                    make.width.equalTo(60)
                    make.centerX.equalTo(self.profileMenuButton.snp.centerX)
                    make.centerY.equalTo(self.view.snp.bottom)
                }
                self.homeMenuButton.snp.remakeConstraints { (make) -> Void in
                    make.height.equalTo(22)
                    make.width.equalTo(25)
                    make.centerX.equalTo(self.view.snp.centerX)
                    make.bottom.equalTo(self.view.snp.bottom).offset(-25)
                }
                self.profileMenuButton.superview?.layoutIfNeeded()
            })
            horizontalScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    
    @objc func didTapHomeButton(sender: UIButton) {
        if currentController != 0 {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.beginFromCurrentState, .curveEaseOut], animations: {
                self.placesMenuButton.snp.updateConstraints { (make) -> Void in
                    make.right.equalTo(self.view.snp.right).offset(-50)
                }
                self.profileMenuButton.snp.updateConstraints { (make) -> Void in
                    make.left.equalTo(self.view.snp.left).offset(50)
                }
                self.selectionMenuBar.snp.remakeConstraints { (make) -> Void in
                    make.height.equalTo(10)
                    make.width.equalTo(60)
                    make.centerX.equalTo(self.homeMenuButton.snp.centerX)
                    make.centerY.equalTo(self.view.snp.bottom)
                }
                self.homeMenuButton.snp.remakeConstraints { (make) -> Void in
                    make.height.equalTo(41)
                    make.width.equalTo(45)
                    make.centerX.equalTo(self.view.snp.centerX)
                    make.bottom.equalTo(self.view.snp.bottom).offset(-25)
                }
                self.profileMenuButton.superview?.layoutIfNeeded()
            })
            horizontalScrollView.setContentOffset(CGPoint(x: view.frame.size.width, y: 0), animated: true)
        }
    }
    
    @objc func didTapPlacesButton(sender: UIButton) {
        if currentController != 1 {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.beginFromCurrentState, .curveEaseOut], animations: {
                self.placesMenuButton.snp.updateConstraints { (make) -> Void in
                    make.right.equalTo(self.view.snp.right).offset(-100)
                }
                self.profileMenuButton.snp.updateConstraints { (make) -> Void in
                    make.left.equalTo(self.view.snp.left).offset(100)
                }
                self.selectionMenuBar.snp.remakeConstraints { (make) -> Void in
                    make.height.equalTo(10)
                    make.width.equalTo(60)
                    make.centerX.equalTo(self.placesMenuButton.snp.centerX)
                    make.centerY.equalTo(self.view.snp.bottom)
                }
                self.homeMenuButton.snp.remakeConstraints { (make) -> Void in
                    make.height.equalTo(22)
                    make.width.equalTo(25)
                    make.centerX.equalTo(self.view.snp.centerX)
                    make.bottom.equalTo(self.view.snp.bottom).offset(-25)
                }
                self.profileMenuButton.superview?.layoutIfNeeded()
            })
            horizontalScrollView.setContentOffset(CGPoint(x: view.frame.size.width * 2, y: 0), animated: true)
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.tag == 10 {
            titleManagerHorizontal(scrollX: scrollView.contentOffset.x)
            menuManagerHorizontal(scrollX: scrollView.contentOffset.x)
            
            // disable vertical scrolling and scannerVC interactions when scrolling horizontally
            if scrollView.contentOffset.x >= view.frame.width - 20 && scrollView.contentOffset.x <= view.frame.width + 20 {
                scannerVC.view.isUserInteractionEnabled = true
                verticalScrollView.isUserInteractionEnabled = true
            } else {
                scannerVC.view.isUserInteractionEnabled = false
                verticalScrollView.isUserInteractionEnabled = false
            }
            if scrollView.contentOffset.x > view.frame.size.width {
                let alpha = (scrollView.contentOffset.x  - view.frame.size.width) / (view.frame.size.width)
                colorEffectView.image = #imageLiteral(resourceName: "background_gradient_right")
                colorEffectView.alpha = alpha
                statusBarWindow?.alpha = 1 - alpha * 5
                currentController = 1
            } else if scrollView.contentOffset.x < view.frame.size.width {
                let alpha = (scrollView.contentOffset.x / view.frame.size.width)
                colorEffectView.image = #imageLiteral(resourceName: "background_gradient_left")
                colorEffectView.alpha = 1 - alpha
                statusBarWindow?.alpha = alpha
                currentController = -1
            } else {
                currentController = 0
                colorEffectView.image = #imageLiteral(resourceName: "background_gradient_center")
            }
        } else if scrollView.tag == 20 {
            
            if scrollView.contentOffset.y == view.frame.size.height {
                self.horizontalScrollView.isScrollEnabled = false
            } else {
                self.horizontalScrollView.isScrollEnabled = true
            }
            titleManagerVertical(scrollY: scrollView.contentOffset.y)
            
            if scrollView.contentOffset.y > 0 { // contactsVC
                let alpha = (scrollView.contentOffset.y) / (view.frame.size.height)
                colorEffectView.alpha = alpha
                statusBarWindow?.alpha = 1 - alpha * 5
            }
        }
    }
    
    func titleManagerHorizontal(scrollX: CGFloat) {
        if scrollX > view.frame.size.width { // NearbyPlacesVC
            self.titleLabel.snp.updateConstraints { (make) -> Void in
                make.centerX.equalTo(self.view.snp.centerX).offset(((scrollX - view.frame.size.width)/10)*2.5)
            }
            if scrollX < view.frame.size.width * 1.5 {
                self.titleLabel.text = "Bar du Poissonnier"
                let alpha = ((scrollX - view.frame.width * 1.5) * 4) / (view.frame.width * 2)
                self.titleLabel.alpha = alpha * -1
                self.titleLabel.textColor = UIColor(red:0.11, green:0.15, blue:0.18, alpha:1.0)
            } else {
                let alpha = ((scrollX - view.frame.width * 1.5) * 4) / (view.frame.width * 2)
                self.titleLabel.alpha = alpha
                self.titleLabel.text = "Nearby Places"
                self.titleLabel.textColor = .white
            }
        } else if scrollX < view.frame.size.width { // ProfileVC
            self.titleLabel.snp.updateConstraints { (make) -> Void in
                make.centerX.equalTo(self.view.snp.centerX).inset(((scrollX - view.frame.size.width)/10)*3.5)
            }
            if scrollX > view.frame.size.width / 2 {
                self.titleLabel.text = "Bar du Poissonnier"
                let alpha = 1 - (scrollX * 2) / view.frame.width
                self.titleLabel.alpha = alpha * -1
                self.titleLabel.textColor = UIColor(red:0.11, green:0.15, blue:0.18, alpha:1.0)
            } else {
                self.titleLabel.text = "Profile"
                let alpha = 1 - (scrollX * 2) / view.frame.width
                self.titleLabel.alpha = alpha
                self.titleLabel.textColor = .white
            }
        }
    }
    
    func titleManagerVertical(scrollY: CGFloat) {
        if scrollY > 0 { // addressBook
            if scrollY < view.frame.size.height * 0.5 { // addressBook
                self.titleLabel.text = "Bar du Poissonnier"
                let alpha = ((scrollY - self.view.frame.height * 0.5) * 4) / (self.view.frame.height * 2)
                self.titleLabel.textColor = UIColor(red:0.11, green:0.15, blue:0.18, alpha:1.0)
                self.titleLabel.alpha = alpha * -1
            } else {
                self.titleLabel.text = "Carnet d'adresse"
                let alpha = ((scrollY - self.view.frame.height * 0.5) * 4) / (self.view.frame.height * 2)
                self.titleLabel.alpha = alpha
                self.titleLabel.textColor = .white
            }
        }
    }
    
    func menuManagerHorizontal(scrollX: CGFloat) {
        
        if horizontalScrollView.isDecelerating || horizontalScrollView.isDragging {
        
            if scrollX < view.frame.size.width { // Profile
                let offset = 1 - (scrollX / view.frame.width)
                
                self.placesMenuButton.snp.updateConstraints { (make) -> Void in
                    make.right.equalTo(self.view.snp.right).offset(-50 - 50 * offset)
                }
                self.profileMenuButton.snp.updateConstraints { (make) -> Void in
                    make.left.equalTo(self.view.snp.left).offset(50 + 50 * offset)
                }
                self.selectionMenuBar.snp.remakeConstraints { (make) -> Void in
                    make.height.equalTo(10)
                    make.width.equalTo(60)
                    make.centerX.equalTo(self.homeMenuButton.snp.centerX).offset(-77 * offset)
                    make.centerY.equalTo(self.view.snp.bottom)
                }
                self.homeMenuButton.snp.remakeConstraints { (make) -> Void in
                    make.height.equalTo(41 - 19 * offset) //->22
                    make.width.equalTo(45 - 20 * offset) //->25
                    make.centerX.equalTo(self.view.snp.centerX)
                    make.bottom.equalTo(self.view.snp.bottom).offset(-25)
                }
                
            } else if scrollX > view.frame.size.width { // Places
                let offset = ((scrollX - view.frame.width) / view.frame.width)
                
                self.placesMenuButton.snp.updateConstraints { (make) -> Void in
                    make.right.equalTo(self.view.snp.right).offset(-50 - 50 * offset)
                }
                self.profileMenuButton.snp.updateConstraints { (make) -> Void in
                    make.left.equalTo(self.view.snp.left).offset(50 + 50 * offset)
                }
                self.selectionMenuBar.snp.remakeConstraints { (make) -> Void in
                    make.height.equalTo(10)
                    make.width.equalTo(60)
                    make.centerX.equalTo(self.homeMenuButton.snp.centerX).offset(77 * offset)
                    make.centerY.equalTo(self.view.snp.bottom)
                }
                self.homeMenuButton.snp.remakeConstraints { (make) -> Void in
                    make.height.equalTo(41 - 19 * offset) //->22
                    make.width.equalTo(45 - 20 * offset) //->25
                    make.centerX.equalTo(self.view.snp.centerX)
                    make.bottom.equalTo(self.view.snp.bottom).offset(-25)
                }
            }
        }
        
    }
    
    func statusBarHorizontalManager(scrollX: CGFloat) {
        if scrollX > view.frame.size.width {
            if scrollX < view.frame.size.width * 1.5 {
                makeStatusBarDark()
            } else {
                makeStatusBarLight()
            }
        } else if scrollX < view.frame.size.width { // ProfileVC
            if scrollX > view.frame.size.width / 2 {
                makeStatusBarDark()
            } else {
                makeStatusBarLight()
            }
        }
    }
    
    func statusBarVerticalManager(scrollY: CGFloat) {
        if scrollY > 0 {
            if scrollY < view.frame.size.height * 0.5 {
                makeStatusBarDark()
            } else {
                makeStatusBarLight()
            }
        }
    }
    
    func makeStatusBarDark() {
        statusBarIsDark = true
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func makeStatusBarLight() {
        statusBarIsDark = false
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        if statusBarIsDark {
            return .lightContent
        } else {
            return .default
        }
    }
}

extension MenuViewController {
    
    override func updateViewConstraints() {
        
        if !didSetupConstraints {
            
            horizontalScrollView.snp.makeConstraints { (make) -> Void in
                make.centerX.equalTo(view.snp.centerX)
                make.centerY.equalTo(view.snp.centerY)
                make.width.equalTo(view.snp.width)
                make.height.equalTo(view.snp.height)
            }
            verticalScrollView.snp.makeConstraints { (make) -> Void in
                make.centerX.equalTo(view.snp.centerX)
                make.top.equalTo(horizontalScrollView.snp.top)
                make.width.equalTo(view.snp.width)
                make.height.equalTo(view.snp.height)
            }
            profileVC.view.snp.makeConstraints { (make) -> Void in
                make.left.equalTo(horizontalScrollView.snp.left)
                make.bottom.equalTo(view.snp.bottom)
                make.width.equalTo(view.snp.width)
                make.height.equalTo(view.snp.height)
            }
            nearbyPlacesVC.view.snp.makeConstraints { (make) -> Void in
                make.left.equalTo(profileVC.view.snp.right).offset(view.frame.size.width)
                make.bottom.equalTo(view.snp.bottom)
                make.width.equalTo(view.snp.width)
                make.height.equalTo(view.snp.height)
            }
            scannerVC.view.snp.makeConstraints { (make) -> Void in
                make.centerX.equalTo(view.snp.centerX)
                make.centerY.equalTo(view.snp.centerY)
                make.width.equalTo(view.snp.width)
                make.height.equalTo(view.snp.height)
            }
            addressBookVC.view.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(verticalScrollView.snp.top).offset(scannerVC.view.frame.height)
                make.left.equalTo(verticalScrollView.snp.left)
                make.width.equalTo(view.snp.width)
                make.height.equalTo(view.snp.height)
            }
            colorEffectView.snp.makeConstraints { (make) -> Void in
                make.centerX.equalTo(scannerVC.view.snp.centerX)
                make.centerY.equalTo(scannerVC.view.snp.centerY)
                make.width.equalTo(scannerVC.view.snp.width)
                make.height.equalTo(scannerVC.view.snp.height)
            }
            
            // MARK: Header
            titleLabel.snp.makeConstraints { (make) -> Void in
                make.width.equalTo(view.snp.width).multipliedBy(0.7)
                make.centerX.equalTo(view.snp.centerX)
                make.top.equalTo(view.snp.top).offset(50)
            }
            
            // MARK: Navigation Menu
            profileMenuButton.snp.makeConstraints { (make) -> Void in
                make.height.equalTo(22)
                make.width.equalTo(18)
                make.left.equalTo(view.snp.left).offset(50)
                make.bottom.equalTo(self.view.snp.bottom).offset(-30)
            }
            homeMenuButton.snp.makeConstraints { (make) -> Void in
                make.height.equalTo(41)
                make.width.equalTo(45)
                make.centerX.equalTo(view.snp.centerX)
                make.bottom.equalTo(view.snp.bottom).offset(-30)
            }
            placesMenuButton.snp.makeConstraints { (make) -> Void in
                make.height.equalTo(22)
                make.width.equalTo(25)
                make.right.equalTo(view.snp.right).offset(-50)
                make.bottom.equalTo(self.view.snp.bottom).offset(-30)
            }
            selectionMenuBar.snp.makeConstraints { (make) -> Void in
                make.height.equalTo(10)
                make.width.equalTo(60)
                make.centerX.equalTo(homeMenuButton.snp.centerX)
                make.centerY.equalTo(self.view.snp.bottom)
            }
            
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
}

