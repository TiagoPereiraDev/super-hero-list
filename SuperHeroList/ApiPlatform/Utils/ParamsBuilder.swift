//
//  MarvelParamsConstructor.swift
//  ApiPlatform
//
//  Created by Tiago Pereira on 02/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation


// Class that implements Builder pattern in order to set the parameters for marvel
// and return the params ready to send
public class ParamsBuilder {
    private var params:[String: Any] = [:]
    
    public init() {}
    
    /**
    Set the offset params this will allow the api to know from what element should send elements

    - Parameter offset: current number elements we already have

    - Returns: ParamsBulider instance with offset defined
    */
    @discardableResult
    public func setOffset(offset: Int) -> ParamsBuilder {
        params["offset"] = offset
        return self
    }
    
    /**
    Set the limit param this will allow the api to know the total number of elements should be sent at the same time

    - Parameter limit: number elements to fetch

    - Returns: ParamsBulider instance with limit defined
    */
    @discardableResult
    public func setLimit(limit: Int) -> ParamsBuilder {
        params["limit"] = limit
        return self
    }
    
    /**
    Set the nameStartsWith param to search by this param

    - Parameter nameStartsWith: search elements that starts by this name

    - Returns: ParamsBulider instance with nameStartsWith defined
    */
    @discardableResult
    public func setNameStartsWith(nameStartsWith: String) -> ParamsBuilder {
        params["nameStartsWith"] = nameStartsWith
        return self
    }
    
    /**
       Method to build and return all the params defined so far

       - Returns: dictionary with all available params
       */
    public func build() -> [String: Any] {
        return params
    }
}
