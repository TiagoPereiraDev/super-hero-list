//
//  SerieResponse.swift
//  Domain
//
//  Created by Tiago Pereira on 02/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation

public struct SeriesResponseData: Codable {
    public let results: [Serie]
}

public struct SeriesResponse: Codable {
    public let data: SeriesResponseData
}
