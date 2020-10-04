//
//  MarvelRequestAdapter.swift
//  ApiPlatform
//
//  Created by Tiago Pereira on 30/09/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation
import RxAlamofire
import Alamofire
import SwiftHash


// Custom Interceptor to set the keys needed to be used in Marvel API
class MarvelRequestInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        do {
            guard let keysPlistPath = Bundle(for: MarvelRequestInterceptor.self).path(forResource: "Keys", ofType: "plist") else {
                return
            }
            
            let data = try Data(contentsOf: URL(fileURLWithPath: keysPlistPath))
            
            guard let keysPlist = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String: String] else {
                return
            }
            
            var params: [String: String] = [:]
            
            if let publicKey = keysPlist[MarvelConstants.publicKey],
                let privateKey = keysPlist[MarvelConstants.privateKey] {
                let timestamp = NSDate().timeIntervalSince1970
                params["apikey"] = publicKey
                params["ts"] = "\(timestamp)"
                params["hash"] = MD5("\(timestamp)\(privateKey)\(publicKey)").lowercased()
            }
            
            let request = try URLEncoding.queryString.encode(urlRequest, with: params)
            
            completion(.success(request))
            
        } catch {}
    }
}
