//
//  NearbyPlacesUICollectionView.swift
//  LTios
//
//  Created by Paul Bénéteau on 08/10/2017.
//  Copyright © 2017 Tastyapp. All rights reserved.
//

import UIKit
import FSPagerView

class NearbyPlacesUICollectionView: UICollectionView {
    
    let flowLayout = UICollectionViewFlowLayout()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.7)
        super.init(frame: CGRect(), collectionViewLayout: flowLayout)
        commonInit()
        
    }
    
//    private func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        // check if the currentCenteredPage is not the page that was touched
//        if let currentCenteredPage = flowLayout.currentCenteredPage, currentCenteredPage != indexPath.row {
//            // trigger a scrollTo(index: animated:)
//            collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
//        }
//    }
//
    func commonInit() {
        
        allowsMultipleSelection = false
        backgroundColor = .clear
        
        frame = UIScreen.main.bounds
        self.register(NearbyPlacesUICollectionViewCell.self, forCellWithReuseIdentifier: "nearbyPlaceCell")
        
        //    register(NearbyPlacesHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "NearbyPlaceHeader_0")
        //    register(NearbyPlacesHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "NearbyPlaceHeader_1")
        //    register(NearbyPlacesHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "NearbyPlaceHeader_2")
    }
}

