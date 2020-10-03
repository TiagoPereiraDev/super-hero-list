//
//  ComicCollectionViewCell.swift
//  SuperHeroList
//
//  Created by Tiago Pereira on 02/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import UIKit
import Domain
import RxSwift
import ApiPlatform

class DetailedCharacterCollectionViewCell: UICollectionViewCell {
    @IBOutlet var shadowView: UIView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    var imageDisposable: Disposable?
    let disposeBag = DisposeBag()
    
    var item: Any? {
        didSet {
            self.populateCell()
        }
    }
    
    var thumbnail: Thumbnail? {
        didSet {
            setThumbnailImage()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 5
        shadowView.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        self.titleLabel.minimumScaleFactor = 0.8
        self.titleLabel.adjustsFontSizeToFitWidth = true
        
        containerView.layer.cornerRadius = 5
        containerView.layer.masksToBounds = true
        
        setThumbnailPlaceholder()
    }
    
    private func populateCell() {
        if let comic = self.item as? Comic {
            self.titleLabel.text = comic.title
            self.thumbnail = comic.thumbnail
        }
        
        if let serie = self.item as? Serie {
             self.titleLabel.text = serie.title
            self.thumbnail = serie.thumbnail
        }
        
        if let story = self.item as? Story {
             self.titleLabel.text = story.title
            self.thumbnail = story.thumbnail
        }
        
        if let event = self.item as? Domain.Event {
             self.titleLabel.text = event.title
            self.thumbnail = event.thumbnail
        }
    }
    
    private func setThumbnailImage() {
        guard let thumbnail = self.thumbnail else { return }
        
        self.imageDisposable = API.fetchImage(thumbnail: thumbnail).subscribe(onNext: { image in
            DispatchQueue.main.async {
                if let image = image {
                    UIImageView.animate(withDuration: 0.2, delay: 0, options: .transitionCrossDissolve, animations: {
                        self.thumbnailImageView.image = image
                        self.thumbnailImageView.alpha = 1.0
                        self.thumbnailImageView.contentMode = .scaleAspectFill
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
            self.thumbnailImageView.contentMode = .scaleAspectFit
        } , completion: nil)
    }

}
