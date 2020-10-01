//
//  Coordinator.swift
//  SuperHeroList
//
//  Created by Tiago Pereira on 01/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import UIKit


protocol Coordinator {

    var children: [Coordinator] {get set}
    var nav: UINavigationController {get set}
    
    func start()
}
