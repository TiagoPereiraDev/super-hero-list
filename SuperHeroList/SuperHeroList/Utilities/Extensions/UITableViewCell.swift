//
//  UITableViewCell.swift
//  SuperHeroList
//
//  Created by Tiago Pereira on 02/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    static func className() -> String {
        return String(describing: self)
    }
    
    static func registerInTableView(tableView: UITableView) {
        let nib = UINib(nibName: self.className(), bundle: Bundle.main)
        
        tableView.register(nib, forCellReuseIdentifier: self.className())
    }
}
