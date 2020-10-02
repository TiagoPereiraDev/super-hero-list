//
//  DetailedCharacterViewController.swift
//  SuperHeroList
//
//  Created by Tiago Pereira on 02/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import UIKit
import RxSwift

class DetailedCharacterViewController: UIViewController {
    
    var viewModel: DetailedCharacterViewModel?
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var comicsCollectionView: MarvelCollectionView!
    @IBOutlet weak var seriesCollectionView: MarvelCollectionView!
    @IBOutlet weak var storiesCollectionView: MarvelCollectionView!
    @IBOutlet weak var eventsCollectionView: MarvelCollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DetailedCharacterCollectionViewCell.registerInCollectionView(collectionView: self.comicsCollectionView)
        DetailedCharacterCollectionViewCell.registerInCollectionView(collectionView: self.seriesCollectionView)
        DetailedCharacterCollectionViewCell.registerInCollectionView(collectionView: self.storiesCollectionView)
        DetailedCharacterCollectionViewCell.registerInCollectionView(collectionView: self.eventsCollectionView)
        
        self.comicsCollectionView.setConfig(config: .detailedCharacter)
        self.seriesCollectionView.setConfig(config: .detailedCharacter)
        self.storiesCollectionView.setConfig(config: .detailedCharacter)
        self.eventsCollectionView.setConfig(config: .detailedCharacter)
        
        transform()
        // Do any additional setup after loading the view.
    }
}

// View model input and output section
extension DetailedCharacterViewController {
    func transform() {
        guard let viewModel = self.viewModel else { return }
        
        let output = viewModel.transform(
            input: DetailedCharacterViewModel.Input(
                fetchMoreComics: self.comicsCollectionView.fecthMoreElements,
                fetchMoreSeries: self.seriesCollectionView.fecthMoreElements,
                fetchMoreStories: self.storiesCollectionView.fecthMoreElements,
                fetchMoreEvents: self.eventsCollectionView.fecthMoreElements
            )
        )
        
        self.nameLabel.text = output.name
        self.descriptionLabel.text = output.description
        
        self.setComicsCollectionViewData(output: output)
        self.setSeriesCollectionViewData(output: output)
        self.setStoriesCollectionViewData(output: output)
        self.setEventsCollectionViewData(output: output)
    }
}

// Comics Section
extension DetailedCharacterViewController {
    func setComicsCollectionViewData(output: DetailedCharacterViewModel.Output) {
        output.comics.bind(to: self.comicsCollectionView.rx.items){(cv, row, item) -> UICollectionViewCell in
            let tmpCell = cv.dequeueReusableCell(
                withReuseIdentifier: DetailedCharacterCollectionViewCell.className(),
                for: IndexPath(row: row, section: 0)
            )
            
            guard let cell = tmpCell as? DetailedCharacterCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.item = item
            
            return cell
        }.disposed(by: self.disposeBag)
        
        self.comicsCollectionView.registerLoading(loading: output.loadingComics)
        self.comicsCollectionView.registerFetchingMore(fetchingMore: output.fetchingMoreComics)
        
        self.comicsCollectionView.startFetchingElements()
    }
}

// Series Section
extension DetailedCharacterViewController {
    func setSeriesCollectionViewData(output: DetailedCharacterViewModel.Output) {
        output.series.bind(to: self.seriesCollectionView.rx.items){(cv, row, item) -> UICollectionViewCell in
            let tmpCell = cv.dequeueReusableCell(
                withReuseIdentifier: DetailedCharacterCollectionViewCell.className(),
                for: IndexPath(row: row, section: 0)
            )
            
            guard let cell = tmpCell as? DetailedCharacterCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.item = item
            
            return cell
        }.disposed(by: self.disposeBag)
        
        self.seriesCollectionView.registerLoading(loading: output.loadingSeries)
        self.seriesCollectionView.registerFetchingMore(fetchingMore: output.fetchingMoreSeries)
        
        self.seriesCollectionView.startFetchingElements()
    }
}

// Stories Section
extension DetailedCharacterViewController {
    func setStoriesCollectionViewData(output: DetailedCharacterViewModel.Output) {
        output.stories.bind(to: self.storiesCollectionView.rx.items){(cv, row, item) -> UICollectionViewCell in
            let tmpCell = cv.dequeueReusableCell(
                withReuseIdentifier: DetailedCharacterCollectionViewCell.className(),
                for: IndexPath(row: row, section: 0)
            )
            
            guard let cell = tmpCell as? DetailedCharacterCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.item = item
            
            return cell
        }.disposed(by: self.disposeBag)
        
        self.storiesCollectionView.registerLoading(loading: output.loadingStories)
        self.storiesCollectionView.registerFetchingMore(fetchingMore: output.fetchingMoreStories)
        
        self.storiesCollectionView.startFetchingElements()
    }
}

// Events Section
extension DetailedCharacterViewController {
    func setEventsCollectionViewData(output: DetailedCharacterViewModel.Output) {
        output.events.bind(to: self.eventsCollectionView.rx.items){(cv, row, item) -> UICollectionViewCell in
            let tmpCell = cv.dequeueReusableCell(
                withReuseIdentifier: DetailedCharacterCollectionViewCell.className(),
                for: IndexPath(row: row, section: 0)
            )
            
            guard let cell = tmpCell as? DetailedCharacterCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.item = item
            
            return cell
        }.disposed(by: self.disposeBag)
        
        self.eventsCollectionView.registerLoading(loading: output.loadingEvents)
        self.eventsCollectionView.registerFetchingMore(fetchingMore: output.fetchingMoreEvents)
        
        self.eventsCollectionView.startFetchingElements()
    }
}
