//
//  MarvelActivityIndicatorTest.swift
//  SuperHeroListTests
//
//  Created by Tiago Pereira on 04/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

class MarvelActivityIndicatorTest: XCTestCase {
    var disposeBag: DisposeBag!
    var container: UIView!
    
    override func setUp() {
        container = UIView()
        disposeBag = DisposeBag()
    }
    
    func testLoading() {
        let expectation = XCTestExpectation(description: "Waiting for loading")
        let activityIndicator = MarvelActivityIndicator(container: container)
        
        let loading = PublishSubject<Bool>()
        
        activityIndicator.registerLoading( loading: loading).subscribe(onNext: { _ in
            XCTAssertTrue(activityIndicator.isActivityInContainer())
            XCTAssertTrue(activityIndicator.isActivityIndicatorAnimating())
            expectation.fulfill()
        }).disposed(by: self.disposeBag)
        
        loading.onNext(true)
        
       wait(for: [expectation], timeout: 1)
    }
    
    func testNotLoading() {
        let expectation = XCTestExpectation(description: "Waiting for loading")
        let activityIndicator = MarvelActivityIndicator(container: container)
         
        let loading = PublishSubject<Bool>()
        
        XCTAssertFalse(activityIndicator.isActivityInContainer())
        XCTAssertFalse(activityIndicator.isActivityIndicatorAnimating())
        
        activityIndicator.registerLoading( loading: loading)
            .subscribe(onNext: { isLoading in
                if !isLoading {
                    XCTAssertFalse(activityIndicator.isActivityInContainer())
                    XCTAssertFalse(activityIndicator.isActivityIndicatorAnimating())
                    expectation.fulfill()
                }
            }).disposed(by: self.disposeBag)
        
        loading.onNext(true)
        loading.onNext(false)
         
        wait(for: [expectation], timeout: 1)
    }

}
