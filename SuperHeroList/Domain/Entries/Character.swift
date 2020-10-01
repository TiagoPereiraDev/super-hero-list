//
//  File.swift
//  Domain
//
//  Created by Tiago Pereira on 28/09/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation

public struct Character: Codable {
    public let id: Double
    public let name: String
    public var description: String?
    public let thumbnail: Thumbnail 
}
