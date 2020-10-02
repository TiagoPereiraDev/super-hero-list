//
//  ComicResponse.swift
//  Domain
//
//  Created by Tiago Pereira on 02/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation

public struct ComicsResponseData: Codable {
    public let results: [Comic]
}

public struct ComicsResponse: Codable {
    public let data: ComicsResponseData
}
