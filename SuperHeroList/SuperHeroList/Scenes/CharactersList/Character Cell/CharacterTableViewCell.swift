//
//  CharacterTableViewCell.swift
//  SuperHeroList
//
//  Created by Tiago Pereira on 02/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import UIKit
import Domain
import ApiPlatform
import RxSwift

class CharacterTableViewCell: UITableViewCell {
    let disposeBag = DisposeBag()
    
    var character: Character? {
        didSet {
            DispatchQueue.main.async {
                self.populateCell()
            }
        }
    }
    
    var imageDisposable: Disposable?
    
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var containerView: UIView!
    @IBOutlet var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.4
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 8
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        containerView.layer.cornerRadius = 5
        containerView.layer.masksToBounds = true
        self.contentView.backgroundColor = Colors.lightGray
        
        self.setThumbnailPlaceholder()
        
        self.titleLabel.textColor = Colors.black
    }

    func populateCell() {
        guard let character = self.character else { return }
        
        self.titleLabel.text = character.name
        
        self.imageDisposable = API.fetchImage(thumbnail: character.thumbnail).subscribe(onNext: { image in
            DispatchQueue.main.async {
                if let image = image {
                    UIImageView.animate(withDuration: 0.2, delay: 0, options: .transitionCrossDissolve, animations: {
                        self.thumbnailImageView.image = image
                        self.thumbnailImageView.alpha = 1.0
                    } , completion: nil)
                    
                }
            }
        })
    }
    
    override func prepareForReuse() {
        self.setThumbnailPlaceholder()
        self.imageDisposable?.dispose()
    }
    
    private func setThumbnailPlaceholder() {
        UIImageView.animate(withDuration: 0.2, delay: 0, options: .transitionCrossDissolve, animations: {
            self.thumbnailImageView.alpha = 0.5
            self.thumbnailImageView?.image = UIImage(named: "marvel")
        } , completion: nil)
    }
}
