//
//  Thumbnail.swift
//  Domain
//
//  Created by Tiago Pereira on 28/09/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation

public struct Thumbnail: Codable {
    public let path: String
    public let ext: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}
