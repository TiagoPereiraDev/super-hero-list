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

extension Session {
    static let marvelSession = Session(interceptor: MarvelRequestInterceptor())
}
