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

public class CharactersUseCase: ListCharactersUseCase {
    
    let network: Network
    
    init(endpoint: String) {
        self.network = Network(endpoint)
    }
    
    public func characters(offset: Int, search: String?) -> Observable<CharactersResponse> {
        var parameters: [String: Any] = [
            "offset":offset,
            "limit": MarvelConstants.limit
        ];
        
        if let noEmptySearch = search, !noEmptySearch.isEmpty {
            parameters["nameStartsWith"] = noEmptySearch
        }
        
        return network.getItems(MarvelConstants.endpointCharacters,parameters: parameters).map { data -> CharactersResponse in
            return try JSONDecoder().decode(CharactersResponse.self, from: data)
        }
    }
}
