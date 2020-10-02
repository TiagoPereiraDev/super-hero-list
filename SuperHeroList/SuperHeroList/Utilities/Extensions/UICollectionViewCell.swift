//
//  UICollectionViewCell.swift
//  SuperHeroList
//
//  Created by Tiago Pereira on 02/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    static func className() -> String {
        return String(describing: self)
    }
    
    static func registerInCollectionView(collectionView: UICollectionView) {
        let nib = UINib(nibName: self.className(), bundle: Bundle.main)
        
        collectionView.register(nib, forCellWithReuseIdentifier: self.className())
    }
}
