//
//  TestParamsBuilder.swift
//  ApiPlatformTests
//
//  Created by Tiago Pereira on 03/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import XCTest
import ApiPlatform

class ParamsBuilderTest: XCTestCase {
    func testInstance() {
        let firstInstance = ParamsBuilder()
        
        let secondInstance = firstInstance.setLimit(limit: 10)
        
        guard let firstLimit = firstInstance.build()["limit"] as? Int,
            let secondLimit = secondInstance.build()["limit"] as? Int else {
                XCTFail("Invalid values")
                return
        }
        
        XCTAssertEqual(firstLimit, secondLimit)
    }
    
    func testParams() {
        let params = ParamsBuilder()
            .setLimit(limit: 10)
            .setOffset(offset: 10)
            .setNameStartsWith(nameStartsWith: "test")
        .build()
        
        guard let limit = params["limit"] as? Int,
            let offset = params["offset"] as? Int,
            let nameStartsWith = params["nameStartsWith"] as? String else {
                XCTFail("Invalid values")
                return
        }
        
        XCTAssertEqual(limit, 10)
        XCTAssertEqual(offset, 10)
        XCTAssertEqual(nameStartsWith, "test")
        
    }
}
