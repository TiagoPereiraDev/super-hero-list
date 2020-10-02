//
//  CharacterTableViewCell.swift
//  SuperHeroList
//
//  Created by Tiago Pereira on 02/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import UIKit
import Domain

class CharacterTableViewCell: UITableViewCell {
    
    var character: Character? {
        didSet {
            DispatchQueue.main.async {
                self.populateCell()
            }
        }
    }
    
    @IBOutlet var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func populateCell() {
        guard let character = self.character else { return }
        
        self.titleLabel.text = character.name
    }
    
}
