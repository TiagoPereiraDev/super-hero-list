//
//  StoryResponse.swift
//  Domain
//
//  Created by Tiago Pereira on 02/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation

public struct StoriesResponseData: Codable {
    public let results: [Story]
}

public struct StoriesResponse: Codable {
    public let data: StoriesResponseData
}
