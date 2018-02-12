//
//  NearbyPlacesUICollectionViewCell.swift
//  LTios
//
//  Created by Paul Bénéteau on 08/10/2017.
//  Copyright © 2017 Tastyapp. All rights reserved.
//

import UIKit

class NearbyPlacesUICollectionViewCell: UICollectionViewCell {
    
    let queue = SerialOperationQueue()
    
    let shadowEffectView = viewWithShadow()
    let placeImageView = ImageViewWithGradient()
    
    let publicNameLabel = UILabel()
    let distanceIcon = UIImageView()
    let distanceLabel = UILabel()
    let peopleLabel = UILabel()
    let typeLabel = UILabel()
    let peopleIcon = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareForReuse()
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        
        placeImageView.backgroundColor = .clear
        placeImageView.clipsToBounds = true
        placeImageView.contentMode = .scaleAspectFill
        placeImageView.layer.cornerRadius = 15
        
        publicNameLabel.font = LTFont.NearbyPlaces.TableView.Cell.name
        publicNameLabel.textColor = .white
        
        distanceIcon.image = UIImage(named: "ic_location")
        
        distanceLabel.font = LTFont.NearbyPlaces.TableView.Cell.distance
        distanceLabel.textColor = .white
        
        typeLabel.font = LTFont.NearbyPlaces.TableView.Cell.type
        typeLabel.textColor = .white
        
        peopleLabel.font = LTFont.NearbyPlaces.TableView.Cell.people
        peopleLabel.textColor = .white
        peopleLabel.textAlignment = .right
        
        peopleIcon.image = UIImage(named: "ic_persons")
        
        contentView.addSubview(shadowEffectView)
        contentView.addSubview(placeImageView)
        contentView.addSubview(publicNameLabel)
        contentView.addSubview(distanceIcon)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(peopleLabel)
        contentView.addSubview(peopleIcon)
        
        self.updateConstraints()
    }
    
    
    override func updateConstraints() {
        
        placeImageView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(contentView.snp.width).multipliedBy(0.95)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.97)
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(contentView.snp.top)
        }
        shadowEffectView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(placeImageView.snp.width)
            make.height.equalTo(placeImageView.snp.height)
            make.center.equalTo(placeImageView.snp.center)
        }
        typeLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(placeImageView.snp.width).multipliedBy(0.65)
            make.left.equalTo(placeImageView.snp.left).offset(10)
            make.bottom.equalTo(publicNameLabel.snp.top).inset(-5)
        }
        publicNameLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(placeImageView.snp.width).multipliedBy(0.65)
            make.left.equalTo(typeLabel.snp.left)
            make.bottom.equalTo(placeImageView.snp.bottom).multipliedBy(0.85)
        }
        distanceIcon.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(20)
            make.width.equalTo(distanceIcon.snp.height).multipliedBy(0.70683333)
            make.left.equalTo(publicNameLabel.snp.left)
            make.bottom.equalTo(placeImageView.snp.bottom).multipliedBy(0.95)
        }
        distanceLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(placeImageView.snp.width).multipliedBy(0.65)
            make.left.equalTo(distanceIcon.snp.left).offset(20)
            make.centerY.equalTo(distanceIcon.snp.centerY)
        }
        peopleLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(30)
            make.height.equalTo(21)
            make.right.equalTo(placeImageView.snp.right).offset(-15)
            make.centerY.equalTo(distanceIcon.snp.centerY)
        }
        peopleIcon.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(distanceIcon.snp.height)
            make.height.equalTo(peopleIcon.snp.width)
            make.right.equalTo(peopleLabel.snp.left)
            make.centerY.equalTo(distanceIcon.snp.centerY)
        }
        super.updateConstraints()
    }
}

class SerialOperationQueue: OperationQueue
{
    override init() {
        super.init()
        maxConcurrentOperationCount = 1
    }
}

class ImageViewWithGradient: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.7).cgColor]
        gradientLayer.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.height / 2, width: self.frame.width, height: self.frame.height / 2)
        
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale;
        
        self.layer.addSublayer(gradientLayer)
    }
}

class viewWithShadow: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        addShadow(offset: CGSize(width: 0, height: 2), color: UIColor.black, radius: 10, opacity: 0.15)
    }
}

