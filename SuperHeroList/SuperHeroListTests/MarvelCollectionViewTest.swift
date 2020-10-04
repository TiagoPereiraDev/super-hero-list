//
//  MarvelCollectionViewTest.swift
//  SuperHeroListTests
//
//  Created by Tiago Pereira on 04/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import XCTest
import RxTest
import RxSwift

class MarvelCollectionViewTest: XCTestCase {
    var disposeBag: DisposeBag!
    var collectionView: MarvelCollectionView?
    var container = UIView()
    
    override func setUp() {
        disposeBag = DisposeBag()
        collectionView = MarvelCollectionView.instatiate()
    }
    
    func testConfiguration() {
        let configType: MarvelCVConfigurationType = .detailedCharacter
        
        XCTAssertNil(collectionView?.getCurrentConfig())
        
        collectionView?.setConfig(config: configType)
        
        XCTAssertEqual(collectionView?.getCurrentConfig(), MarvelCVConfiguration.build(type: configType))
    }
    
    func testActivityIndicator() {
        guard let collectionView = self.collectionView else {
            XCTFail("No Collection view")
            return
        }
        
        let expectation = XCTestExpectation(description: "Waiting for loading")
        
        collectionView.setConfig(config: .detailedCharacter)
        
        let loading = PublishSubject<Bool>()
        
        collectionView.registerLoading(loading: loading)?.subscribe(onNext: { loading in
            XCTAssertTrue(collectionView.isActivityIndicatorAnimating())
            expectation.fulfill()
        }).disposed(by: self.disposeBag)
        
        loading.onNext(true)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchingMore() {
        guard let collectionView = self.collectionView else {
            XCTFail("No Collection view")
            return
        }
        
        let expectation = XCTestExpectation(description: "Waiting for loading")
        
        collectionView.setConfig(config: .detailedCharacter)
        
        let fetchingMore = PublishSubject<Bool>()
        
        collectionView.registerFetchingMore(fetchingMore: fetchingMore)
            .subscribe(onNext: { fetchingMore in
                XCTAssertTrue(collectionView.isFetchingMoreShown())
                expectation.fulfill()
            }).disposed(by: self.disposeBag)
        
        fetchingMore.onNext(true)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testNoDataLabel() {
        guard let collectionView = self.collectionView else {
            XCTFail("No Collection view")
            return
        }
        
        let expectation = XCTestExpectation(description: "Waiting for loading")
        
        collectionView.setConfig(config: .detailedCharacter)
        
        let noData = PublishSubject<Bool>()
        
        collectionView.registerForNoData(noDataObs: noData)?
            .subscribe(onNext: { noData in
                XCTAssertTrue(collectionView.isNoDataLabelVisible())
                expectation.fulfill()
            }).disposed(by: self.disposeBag)
        
        noData.onNext(true)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testStartFetching() {
        guard let collectionView = self.collectionView else {
            XCTFail("No Collection view")
            return
        }
        
        let expectation = XCTestExpectation(description: "Waiting for loading")
        
        collectionView.setConfig(config: .detailedCharacter)
        
        collectionView.fecthMoreElements.subscribe(onNext: { () in
            XCTAssertTrue(true)
            expectation.fulfill()
        }).disposed(by: self.disposeBag)
        
        collectionView.startFetchingElements()
        
        wait(for: [expectation], timeout: 1)
    }
}
