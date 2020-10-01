//
//  CharactersResult.swift
//  Domain
//
//  Created by Tiago Pereira on 28/09/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation

public struct CharactersResponseData: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let result: [Character]
}

public struct CharactersResponse: Codable {
    public let data: CharactersResponseData
}
