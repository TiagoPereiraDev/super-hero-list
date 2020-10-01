//
//  UIViewController.swift
//  SuperHeroList
//
//  Created by Tiago Pereira on 01/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    static func instatiate() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
}
