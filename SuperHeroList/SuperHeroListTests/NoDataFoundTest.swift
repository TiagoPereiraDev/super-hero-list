//
//  NoDataFoundTest.swift
//  SuperHeroListTests
//
//  Created by Tiago Pereira on 04/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

class NoDataFoundTest: XCTestCase {
    var disposeBag: DisposeBag!
    var container: UIView!
    var noDataHandler: NoDataHandler!
    
    override func setUp() {
        container = UIView()
        disposeBag = DisposeBag()
        noDataHandler = NoDataHandler(container: container)
    }
    
    func testUpdateMessage() {
        let testMessage = "Test"
        
        XCTAssertNotNil(noDataHandler.getCurrentMessage())
        
        noDataHandler.updateMessage(message: testMessage)
        
        XCTAssertEqual(noDataHandler.getCurrentMessage(), testMessage)
        
    }
    
    func testNoResults() {
        let expectation = XCTestExpectation(description: "Waiting for data")
        
        let noResults = PublishSubject<Bool>()
        
        XCTAssertFalse(self.noDataHandler.isNoDataLabelVisible())
        
        noDataHandler.regiterDataObserver(obs: noResults).subscribe(onNext: { noData in
            XCTAssertTrue(self.noDataHandler.isNoDataLabelVisible())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        noResults.onNext(true)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testResults() {
        let expectation = XCTestExpectation(description: "Waiting for data")
        
        let noResults = PublishSubject<Bool>()
        
        XCTAssertFalse(self.noDataHandler.isNoDataLabelVisible())
        
        noDataHandler.regiterDataObserver(obs: noResults).subscribe(onNext: { noData in
            XCTAssertFalse(self.noDataHandler.isNoDataLabelVisible())
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        noResults.onNext(false)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testResultsSwitch() {
        let expectation = XCTestExpectation(description: "Waiting for data")
        
        let noResults = PublishSubject<Bool>()
        
        XCTAssertFalse(self.noDataHandler.isNoDataLabelVisible())
        
        noDataHandler.regiterDataObserver(obs: noResults).subscribe(onNext: { noData in
            if noData {
                XCTAssertTrue(self.noDataHandler.isNoDataLabelVisible())
            } else {
                XCTAssertFalse(self.noDataHandler.isNoDataLabelVisible())
                expectation.fulfill()
            }
        }).disposed(by: disposeBag)
        
        noResults.onNext(true)
        noResults.onNext(false)
        
        wait(for: [expectation], timeout: 1)
    }
}
