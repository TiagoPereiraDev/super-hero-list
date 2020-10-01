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
    
    public func characters(offset: Int) -> Observable<CharactersResponse> {
        return network.getItems(MarvelConstants.endpointCharacters).map { data -> CharactersResponse in
            return try JSONDecoder().decode(CharactersResponse.self, from: data)
        }
    }
}
