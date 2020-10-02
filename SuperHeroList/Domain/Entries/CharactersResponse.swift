//
//  CharactersResult.swift
//  Domain
//
//  Created by Tiago Pereira on 28/09/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation

public struct CharactersResponseData: Codable {
    public let offset: Int
    public let limit: Int
    public let total: Int
    public let count: Int
    public let results: [Character]
}

public struct CharactersResponse: Codable {
    public let data: CharactersResponseData
}
