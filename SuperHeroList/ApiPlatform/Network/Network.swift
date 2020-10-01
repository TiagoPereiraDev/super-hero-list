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



internal final class Network {

    private let endPoint: String
    private let scheduler: ConcurrentDispatchQueueScheduler
    
    init(_ endPoint: String) {
        self.endPoint = endPoint
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    }

    func getItems(_ path: String) -> Observable<Data> {
        let absolutePath = "\(endPoint)/\(path)"
        return Session.marvelSession.rx
            .request(.get, absolutePath)
            .debug()
            .responseData()
            .observeOn(scheduler)
            .map { (response, data) -> Data in
//                if response.statusCode != 200 {
//                    print("### Error \(String(data: data, encoding: .utf8))")
//                }
                
                return data
        }
    }

    func getItem(_ path: String, itemId: String) -> Observable<Data> {
        let absolutePath = "\(endPoint)/\(path)/\(itemId)"
        return Session.marvelSession.rx
            .data(.get, absolutePath)
            .debug()
            .observeOn(scheduler)
    }

    func postItem(_ path: String, parameters: [String: Any]) -> Observable<Data> {
        let absolutePath = "\(endPoint)/\(path)"
        return Session.marvelSession.rx
            .request(.post, absolutePath, parameters: parameters)
            .debug()
            .observeOn(scheduler)
            .data()
    }
}
