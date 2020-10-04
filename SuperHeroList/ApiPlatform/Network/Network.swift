//  Network.swift
//  NetworkPlatform
//
//  Created by Tiago Pereira on 29/09/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation
import Alamofire
import Domain
import RxAlamofire
import RxSwift

// Network class to be used internally in order to obtain data from the marvel api
internal final class Network {

    private let endPoint: String
    private let scheduler: ConcurrentDispatchQueueScheduler
    
    init(_ endPoint: String) {
        self.endPoint = endPoint
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    }
    
    /**
    method that will fetch data with the list of elements inside

    - Parameter path: the endpoint to be used in order to fetch this data
    - Parameter parameters: all the relevant parameters to be used in this query

    - Returns: Observable with data from the request
    */
    func getItems(_ path: String, parameters: [String: Any]?) -> Observable<Data> {
        let absolutePath = "\(endPoint)/\(path)"
        return Session.marvelSession.rx
            .request(.get, absolutePath, parameters: parameters)
            .debug()
            .responseData()
            .observeOn(scheduler)
            .map { (response, data) -> Data in
                return data
        }
    }
}
