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
import UIScrollView_InfiniteScroll

/// Enum that will have all the available configurations to set the view
enum MarvelCVConfigurationType {
    case detailedCharacter
}

/// Struct with all the data needed to do the collection view configuration
struct MarvelCVConfiguration: Equatable {
    let activityIndicator: Bool
    let itemSize: CGSize
    let infinitScroll: Bool
    let vertical: Bool
    
    /**
    Method that will build the configuration based on the config passed
     
    - Parameter type: type of configuration to apply on view
     
    - Returns: configuration to set the view base on type passed
    */
    static func build(type: MarvelCVConfigurationType) -> MarvelCVConfiguration  {
        switch type {
        case .detailedCharacter:
            return MarvelCVConfiguration(
                activityIndicator: true,
                itemSize: CGSize(width: 200, height: 280),
                infinitScroll: true,
                vertical: false
            )
        }
    }
    
    static func ==(lhs: MarvelCVConfiguration, rhs: MarvelCVConfiguration) -> Bool {
        return lhs.activityIndicator == rhs.activityIndicator &&
            lhs.itemSize == rhs.itemSize &&
            lhs.infinitScroll == rhs.infinitScroll &&
            lhs.vertical == rhs.vertical
    }
}

/// Class to add some functionalitites to a collection view in order to fit with the app requirements
/// Some custom elements are gonna be defined here like activity indicator, infinite load, no data label results etc..
class MarvelCollectionView: UICollectionView {
    let fecthMoreElements = PublishSubject<Void>()
    private let fetchingMoreElements = PublishSubject<Bool>()
    private let disposeBag = DisposeBag()
    private var activityIndicator: MarvelActivityIndicator?
    private var noDataHandler: NoDataHandler?
    
    private var currentConfiguration: MarvelCVConfiguration? {
        didSet { applyConfiguration() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.noDataHandler = NoDataHandler(container: self)
    }
    
    /**
    Method that will call the configuration builder and set it to the view
     
    - Parameter config: type of configuration to apply on view
    */
    func setConfig(config: MarvelCVConfigurationType) {
        self.currentConfiguration = MarvelCVConfiguration.build(type: config)
    }
    
    /**
    Method that will return current view configuration
     
    - Returns: current view configuration
    */
    func getCurrentConfig() -> MarvelCVConfiguration? {
        return self.currentConfiguration
    }
    
    /**
    Method called when a new configuration is defined, it will apply this configurations on the view
    */
    private func applyConfiguration() {
        guard let config = self.currentConfiguration else { return }
        
        if config.activityIndicator {
            self.activityIndicator = MarvelActivityIndicator(container: self)
        }
        
        if let flow = self.collectionViewLayout as? UICollectionViewFlowLayout{
            flow.scrollDirection = config.vertical ? .vertical : .horizontal
            flow.itemSize = config.itemSize
        }
        
        if config.infinitScroll {
            self.infiniteScrollDirection = config.vertical ? .vertical : .horizontal
            
            let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
                   activityIndicator.color = Colors.red
                   
            self.infiniteScrollIndicatorView = activityIndicator
            
            
            self.addInfiniteScroll { (cv) in
                self.fecthMoreElements.onNext(Void())
            }
        }
    }
    
    /**
     Register the loading observer to know when to show / hidde the activity indicator
     
     - Parameter loading: loading observer responsable for the process that's going on
     
     - Returns: Observable to notify when loading changes were aplied indicating if is loading or not or nil case no activity indicator
     */
    @discardableResult
    func registerLoading(loading: Observable<Bool>) -> Observable<Bool>? {
        return self.activityIndicator?.registerLoading(loading: loading)
    }
    
    /**
    Method to check if activity indicator is animating or not
    
    - Returns: Bool value indicating if activity indicator is animating or not
    */
    public func isActivityIndicatorAnimating() -> Bool {
        guard let activityIndicator = self.activityIndicator else { return false }
        
        return activityIndicator.isActivityIndicatorAnimating()
    }
    
    /**
    Method to check if activity indicator is animating or not
    
    - Returns: Bool value indicating if activity indicator is animating or not
    */
     @discardableResult
    func registerFetchingMore(fetchingMore: Observable<Bool>) -> Observable<Bool> {
        fetchingMore.subscribe(onNext: { fetching in
            DispatchQueue.main.async {
                if !fetching {
                    self.finishInfiniteScroll()
                    
                } else {
                    self.beginInfiniteScroll(false)
                }
                self.fetchingMoreElements.onNext(fetching)
            }
        }).disposed(by: self.disposeBag)
        
        return self.fetchingMoreElements
    }
    
    /**
    Method that will return if fetching more indicator is visible or not
     
    - Returns: Bool value indicating if the fetching more indicator is visible or not
    */
    func isFetchingMoreShown() -> Bool {
        return self.isAnimatingInfiniteScroll
    }
    
    /**
    Method that will start observing if there's data or not to show no results label
    
    - Parameter obs: Observer that will notify if no data
     
    - Returns: Observable that will notify that changes were made and if no data state or nil case the noDataHandler is not available
    */
    @discardableResult
    func registerForNoData(noDataObs: Observable<Bool>) -> Observable<Bool>? {
        return self.noDataHandler?.regiterDataObserver(obs: noDataObs)
    }
    
    /**
    Method that will return if the no resuts label is visible or not
     
    - Returns: Bool value indicating if the no results label is visible or not
    */
    func isNoDataLabelVisible() -> Bool {
        guard let noDataHandler = self.noDataHandler else { return false }
        
        return noDataHandler.isNoDataLabelVisible()
    }
    
    func startFetchingElements() {
        self.fecthMoreElements.onNext(Void())
    }
}
