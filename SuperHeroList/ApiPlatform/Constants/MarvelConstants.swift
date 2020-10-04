//
//  MarvelEndpoints.swift
//  ApiPlatform
//
//  Created by Tiago Pereira on 30/09/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation

// Generic Marvel Constants
internal struct MarvelConstants {
    static let apiVersion = "v1"
    static let publicApi = "public"
    static let basePath = "https://gateway.marvel.com"
    static let privateKey = "MARVEL_PRIVATE_KEY"
    static let publicKey = "MARVEL_PUBLIC_KEY"
    static let limit = 30
}

// Endpoints constants
internal extension MarvelConstants {
    static let endpointCharacters = "characters"
    static let endpointComics = "comics"
    static let endpointSeries = "series"
    static let endpointStories = "stories"
    static let endpointEvents = "events"
}
