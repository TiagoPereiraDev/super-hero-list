//
//  ComicCollectionViewCell.swift
//  SuperHeroList
//
//  Created by Tiago Pereira on 02/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import UIKit
import Domain

class DetailedCharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    
    var item: Any? {
        didSet {
            self.populateCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populateCell() {
        if let comic = self.item as? Comic {
            self.titleLabel.text = comic.title
        }
        
        if let serie = self.item as? Serie {
             self.titleLabel.text = serie.title
        }
        
        if let story = self.item as? Story {
             self.titleLabel.text = story.title
        }
        
        if let event = self.item as? Event {
             self.titleLabel.text = event.title
        }
        
        
        
        
    }

}
