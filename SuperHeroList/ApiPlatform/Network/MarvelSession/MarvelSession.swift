//
//  MarvelSession.swift
//  ApiPlatform
//
//  Created by Tiago Pereira on 30/09/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire

// Session extension to use the marvel session with the custom interceptor
extension Session {
    static let marvelSession = Session(interceptor: MarvelRequestInterceptor())
}
