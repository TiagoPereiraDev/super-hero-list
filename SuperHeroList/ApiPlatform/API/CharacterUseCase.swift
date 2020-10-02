//
//  CharacterUseCase.swift
//  ApiPlatform
//
//  Created by Tiago Pereira on 02/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation
import Domain
import RxSwift

public class CharacterUseCase: DetailedCharacterUseCase {
    let network: Network
    
    init(endpoint: String) {
        self.network = Network(endpoint)
    }
    
    public func comics(offset: Int, characterId: Double) -> Observable<ComicsResponse> {
        let params = ParamsBuilder()
        .setOffset(offset: offset)
        .setLimit(limit: MarvelConstants.limit)
        
        return network.getItems(
            MarvelConstants.endpointComics,
            parameters: params.build()
        ).map { data -> ComicsResponse in
            return try JSONDecoder().decode(ComicsResponse.self, from: data)
        }
    }
    
    public func series(offset: Int, characterId: Double) -> Observable<SeriesResponse> {
        let params = ParamsBuilder()
        .setOffset(offset: offset)
        .setLimit(limit: MarvelConstants.limit)
        
        return network.getItems(
            MarvelConstants.endpointSeries,
            parameters: params.build()
        ).map { data -> SeriesResponse in
            return try JSONDecoder().decode(SeriesResponse.self, from: data)
        }
    }
    
    public func stories(offset: Int, characterId: Double) -> Observable<StoriesResponse> {
        let params = ParamsBuilder()
        .setOffset(offset: offset)
        .setLimit(limit: MarvelConstants.limit)
        
        return network.getItems(
            MarvelConstants.endpointStories,
            parameters: params.build()
        ).map { data -> StoriesResponse in
            return try JSONDecoder().decode(StoriesResponse.self, from: data)
        }
    }
    
    public func events(offset: Int, characterId: Double) -> Observable<EventsResponse> {
        let params = ParamsBuilder()
        .setOffset(offset: offset)
        .setLimit(limit: MarvelConstants.limit)
        
        return network.getItems(
            MarvelConstants.endpointEvents,
            parameters: params.build()
        ).map { data -> EventsResponse in
            return try JSONDecoder().decode(EventsResponse.self, from: data)
        }
    }
    
    
}
