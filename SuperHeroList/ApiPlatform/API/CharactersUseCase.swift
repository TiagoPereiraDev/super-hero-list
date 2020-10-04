//
//  CharactersApi.swift
//  ApiPlatform
//
//  Created by Tiago Pereira on 30/09/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation
import Domain
import RxSwift


// Use case to be used with Characters, it sets the network for this use case and have all the parameters that gonna be usefull for this use case
public class CharactersUseCase: ListCharactersUseCase {
    
    let network: Network
    
    init(endpoint: String) {
        self.network = Network(endpoint)
    }
    
    /**
    method that will fetch a list of characters based on offset and search

    - Parameter offset: current number elements we already have
    - Parameter nameStartsWith: search elements that starts by this name

    - Returns: Observable with characters list response
    */
    public func characters(offset: Int, search: String?) -> Observable<CharactersResponse> {
        let params = ParamsBuilder()
            .setOffset(offset: offset)
            .setLimit(limit: MarvelConstants.limit)
        
        if let noEmptySearch = search, !noEmptySearch.isEmpty {
            params.setNameStartsWith(nameStartsWith: noEmptySearch)
        }
        
        return network.getItems(
            MarvelConstants.endpointCharacters,
            parameters: params.build()
        ).map { data -> CharactersResponse in
            return try JSONDecoder().decode(CharactersResponse.self, from: data)
        }
    }
}
