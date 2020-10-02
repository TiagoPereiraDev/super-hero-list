//
//  Story.swift
//  Domain
//
//  Created by Tiago Pereira on 02/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation

public struct Story: Codable {
    public let id: Double
    public let title: String
    public var description: String?
    public let thumbnail: Thumbnail?
}
