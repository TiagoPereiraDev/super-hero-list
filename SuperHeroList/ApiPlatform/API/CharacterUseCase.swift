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

// Use case to be used with a sepecific Character, it sets the network for this use case and have all the parameters that gonna be usefull for this use case
public class CharacterUseCase: DetailedCharacterUseCase {
    let network: Network
    
    init(endpoint: String) {
        self.network = Network(endpoint)
    }
    
    /**
    method that will fetch a list of comics related with some character

    - Parameter offset: current number elements we already have
    - Parameter characterId: id of the character that we want to obtain the data from

    - Returns: Observable with comics list response
    */
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
    
    /**
    method that will fetch a list of series related with some character

    - Parameter offset: current number elements we already have
    - Parameter characterId: id of the character that we want to obtain the data from

    - Returns: Observable with series list response
    */
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
    
    /**
    method that will fetch a list of stories related with some character

    - Parameter offset: current number elements we already have
    - Parameter characterId: id of the character that we want to obtain the data from

    - Returns: Observable with stories list response
    */
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
    
    /**
    method that will fetch a list of events related with some character

    - Parameter offset: current number elements we already have
    - Parameter characterId: id of the character that we want to obtain the data from

    - Returns: Observable with events list response
    */
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
