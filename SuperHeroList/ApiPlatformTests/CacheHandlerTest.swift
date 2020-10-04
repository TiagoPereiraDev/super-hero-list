//
//  CacheHandlerTest.swift
//  ApiPlatformTests
//
//  Created by Tiago Pereira on 04/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import XCTest
import ApiPlatform

class CacheHandlerTest: XCTestCase {

    func testGetAndSet() {
        let key = "Key"
        let value = "value"
        let cacheHandler = CacheHandler<NSString>()
        
        XCTAssertNil(cacheHandler.getData(key: key))
        
        cacheHandler.saveData(key: key, value: value as NSString)
        
        XCTAssertEqual(cacheHandler.getData(key: key), value as NSString)
    }
    
    func testCleanValue() {
        let key = "Key"
        let value = "value"
        let cacheHandler = CacheHandler<NSString>()
        
        cacheHandler.saveData(key: key, value: value as NSString)
        
        XCTAssertEqual(cacheHandler.getData(key: key), value as NSString)
        
        cacheHandler.cleanData(key: key)
        
        XCTAssertNil(cacheHandler.getData(key: key))
    }
    
    func testCleanAllData() {
        let key1 = "Key"
        let key2 = "Key2"
        let value = "value"
        
        let cacheHandler = CacheHandler<NSString>()
        
        cacheHandler.saveData(key: key1, value: value as NSString)
        cacheHandler.saveData(key: key2, value: value as NSString)
        
        XCTAssertEqual(cacheHandler.getData(key: key1), value as NSString)
        XCTAssertEqual(cacheHandler.getData(key: key2), value as NSString)
        
        cacheHandler.cleanAllData()
        
        XCTAssertNil(cacheHandler.getData(key: key1))
        XCTAssertNil(cacheHandler.getData(key: key2))
    }

}
