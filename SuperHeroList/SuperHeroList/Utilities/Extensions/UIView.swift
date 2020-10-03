//
//  UIView.swift
//  SuperHeroList
//
//  Created by Tiago Pereira on 03/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    static func instatiate() -> Self? {
        func instantiateFromNib<T: UIView>() -> T? {
            let name = String(describing: T.self)
            let bundle = Bundle(for: T.self)
            
            let nib = UINib(nibName: name, bundle: bundle)
            return nib.instantiate(withOwner: nil, options: nil)[0] as? T
        }

        return instantiateFromNib()
    }
}
