//
//  DetailedCharacterViewModel.swift
//  SuperHeroList
//
//  Created by Tiago Pereira on 02/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation
import Domain
import RxSwift

class DetailedCharacterViewModel: ViewModelType {
    private let character: Character
    private let useCase: DetailedCharacterUseCase
    
    private var comics: [Comic] = []
    private let loadingComics = BehaviorSubject(value: false)
    private let fetchingMoreComics = BehaviorSubject(value: false)
    
    private var series: [Serie] = []
    private let loadingSeries = BehaviorSubject(value: false)
    private let fetchingMoreSeries = BehaviorSubject(value: false)
    
    private var events: [Domain.Event] = []
    private let loadingEvents = BehaviorSubject(value: false)
    private let fetchingMoreEvents = BehaviorSubject(value: false)

    private var stories: [Story] = []
    private let loadingStories = BehaviorSubject(value: false)
    private let fetchingMoreStories = BehaviorSubject(value: false)
    
    init(character: Character, useCase: DetailedCharacterUseCase) {
        self.character = character
        self.useCase = useCase
    }
    
    func transform(input: Input) -> Output {
        let comicsObs = input.fetchMoreComics.flatMap { _ -> Observable<ComicsResponse> in
            if self.comics.count == 0 {
                self.loadingComics.onNext(true)
            } else {
                self.fetchingMoreComics.onNext(true)
            }
            return self.useCase.comics(
                offset: self.comics.count,
                characterId: self.character.id
            )
        }.map { response -> [Comic] in
            self.comics.append(contentsOf: response.data.results)
            self.loadingComics.onNext(false)
            self.fetchingMoreComics.onNext(false)
            return self.comics
        }
        
        let seriesObs = input.fetchMoreSeries.flatMap { _ -> Observable<SeriesResponse> in
            if self.series.count == 0 {
                self.loadingSeries.onNext(true)
            } else {
                self.fetchingMoreSeries.onNext(true)
            }
            return self.useCase.series(
                offset: self.series.count,
                characterId: self.character.id
            )
        }.map { response -> [Serie] in
            self.series.append(contentsOf: response.data.results)
            self.loadingSeries.onNext(false)
            self.fetchingMoreSeries.onNext(false)
            return self.series
        }
        
        let storiesObs = input.fetchMoreStories.flatMap { _ -> Observable<StoriesResponse> in
            if self.stories.count == 0 {
                self.loadingStories.onNext(true)
            } else {
                self.fetchingMoreStories.onNext(true)
            }
            return self.useCase.stories(
                offset: self.stories.count,
                characterId: self.character.id
            )
        }.map { response -> [Story] in
            self.stories.append(contentsOf: response.data.results)
            self.loadingStories.onNext(false)
            self.fetchingMoreStories.onNext(false)
            return self.stories
        }
        
        
        let eventsObs = input.fetchMoreEvents.flatMap { _ -> Observable<EventsResponse> in
                   if self.events.count == 0 {
                       self.loadingEvents.onNext(true)
                   } else {
                       self.fetchingMoreEvents.onNext(true)
                   }
                   return self.useCase.events(
                       offset: self.events.count,
                       characterId: self.character.id
                   )
        }.map { response -> [Domain.Event] in
                   self.events.append(contentsOf: response.data.results)
                   self.loadingEvents.onNext(false)
                   self.fetchingMoreEvents.onNext(false)
                   return self.events
               }
        
        return Output(
            name: self.character.name,
            description: self.character.description,
            thumbnail: self.character.thumbnail,
            comics: comicsObs,
            loadingComics: self.loadingComics,
            fetchingMoreComics: self.fetchingMoreComics,
            series: seriesObs,
            loadingSeries: self.loadingSeries,
            fetchingMoreSeries: self.fetchingMoreSeries,
            stories: storiesObs,
            loadingStories: self.loadingStories,
            fetchingMoreStories: self.fetchingMoreStories,
            events: eventsObs,
            loadingEvents: self.loadingEvents,
            fetchingMoreEvents: self.fetchingMoreEvents
        )
    }
}

extension DetailedCharacterViewModel {
    struct Input {
        let fetchMoreComics: Observable<Void>
        let fetchMoreSeries: Observable<Void>
        let fetchMoreStories: Observable<Void>
        let fetchMoreEvents: Observable<Void>
    }
    
    struct Output {
        let name: String
        let description: String?
        let thumbnail: Thumbnail?
        let comics: Observable<[Comic]>
        let loadingComics: Observable<Bool>
        let fetchingMoreComics: Observable<Bool>
        let series: Observable<[Serie]>
        let loadingSeries: Observable<Bool>
        let fetchingMoreSeries: Observable<Bool>
        let stories: Observable<[Story]>
        let loadingStories: Observable<Bool>
        let fetchingMoreStories: Observable<Bool>
        let events: Observable<[Domain.Event]>
        let loadingEvents: Observable<Bool>
        let fetchingMoreEvents: Observable<Bool>
    }
}
