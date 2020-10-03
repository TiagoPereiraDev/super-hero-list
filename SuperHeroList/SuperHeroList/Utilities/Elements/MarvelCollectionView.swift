//
//  MarvelCollectionView.swift
//  SuperHeroList
//
//  Created by Tiago Pereira on 03/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

enum MarvelCVConfiguration {
    case detailedCharacter
}

class MarvelCollectionView: UICollectionView {
    
    let fecthMoreElements = PublishSubject<Void>()
    let disposeBag = DisposeBag()
    var activityIndicator: MarvelActivityIndicator?
    
    func setConfig(config: MarvelCVConfiguration) {
        if config == .detailedCharacter {
            self.activityIndicator = MarvelActivityIndicator(container: self)
            if let flow = self.collectionViewLayout as? UICollectionViewFlowLayout{
                flow.scrollDirection = .horizontal
                flow.itemSize = CGSize(width: 200, height: 280)
            }
            
            self.infiniteScrollDirection = .horizontal
            
            let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
                   activityIndicator.color = Colors.red
                   
            self.infiniteScrollIndicatorView = activityIndicator
            
            
            self.addInfiniteScroll { (cv) in
                self.fecthMoreElements.onNext(Void())
            }
        }
    }
    
    func registerLoading(loading: Observable<Bool>) {
        self.activityIndicator?.registerLoading(loading: loading)
    }
    
    func registerFetchingMore(fetchingMore: Observable<Bool>) {
        fetchingMore.subscribe(onNext: { fetching in
            DispatchQueue.main.async {
                if !fetching { self.finishInfiniteScroll() }
            }
        }).disposed(by: self.disposeBag)
    }
    
    func startFetchingElements() {
        self.fecthMoreElements.onNext(Void())
    }
}
