//
//  MarvelParamsConstructor.swift
//  ApiPlatform
//
//  Created by Tiago Pereira on 02/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation


class ParamsBuilder {
    private var params:[String: Any] = [:]
    
    @discardableResult
    public func setOffset(offset: Int) -> ParamsBuilder {
        params["offset"] = offset
        return self
    }
    
    @discardableResult
    public func setLimit(limit: Int) -> ParamsBuilder {
        params["limit"] = limit
        return self
    }
    
    @discardableResult
    public func setNameStartsWith(nameStartsWith: String) -> ParamsBuilder {
        params["nameStartsWith"] = nameStartsWith
        return self
    }
    
    public func build() -> [String: Any] {
        return params
    }
}
