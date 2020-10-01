//
//  API.swift
//  ApiPlatform
//
//  Created by Tiago Pereira on 30/09/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation

public class API {
    
    // Computed property to build the base path in order to make calls to the Marvel API
    private static var basePath: String {
        return "\(MarvelConstants.basePath)/\(MarvelConstants.apiVersion)/\(MarvelConstants.publicApi)"
    }
    
    public static func buildCharactersUseCase() -> CharactersUseCase {
        return CharactersUseCase(endpoint: basePath)
    }
    
}
