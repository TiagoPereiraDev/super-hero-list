//
//  CharactersListViewController.swift
//  SuperHeroList
//
//  Created by Tiago Pereira on 01/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import UIKit

class CharactersListViewController: UIViewController {
    
    var viewModel: CharactersListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        transform()
    }
}

// View model input and output section
extension CharactersListViewController {
    func transform() {
        guard let viewModel = self.viewModel else { return }
        
        let output = viewModel.transform(
            input: CharactersListViewModel.Input()
        )
    }
}
