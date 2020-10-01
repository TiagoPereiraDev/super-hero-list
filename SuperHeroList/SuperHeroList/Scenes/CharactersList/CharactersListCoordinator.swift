//
//  CharactersListCoordinator.swift
//  SuperHeroList
//
//  Created by Tiago Pereira on 01/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation
import UIKit
import ApiPlatform

class CharactersListCoordinator: Coordinator {
    var window: UIWindow?
    
    var children = [Coordinator]()
    var nav: UINavigationController
    
    init(window: UIWindow?) {
        self.window = window
        self.nav = UINavigationController()
    }
    
    func start() {
        guard let window = self.window else { return }
        
        let vc = CharactersListViewController.instatiate()
        
        vc.viewModel = CharactersListViewModel(useCase: API.buildCharactersUseCase())
        
        nav.pushViewController(vc, animated: false)
        
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
    
    
}
