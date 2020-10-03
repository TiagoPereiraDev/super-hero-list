//
//  CharactersListViewModel.swift
//  SuperHeroList
//
//  Created by Tiago Pereira on 30/09/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

class CharactersListViewModel: ViewModelType {
    let useCase: ListCharactersUseCase
    private let fetchMoreData = PublishSubject<Void>()
    var charactersList: [Character]
    var lastSearch: String?
    let loading: BehaviorSubject<Bool>;
    let fetchingMore: BehaviorSubject<Bool>;
    
    init(useCase : ListCharactersUseCase) {
        self.useCase = useCase
        charactersList = []
        
        loading = BehaviorSubject(value: false)
        fetchingMore = BehaviorSubject(value: false)
    }
    
    func transform(input: Input) -> Output {
        let cleanData = input.search.asObservable().map{ _ -> [Character] in
            return []
        }
        
        let characters = Observable.combineLatest(
            self.fetchMoreData,
            input.search.asObservable()
        ).map { (_, search) -> String? in
            if search != self.lastSearch {
                self.lastSearch = search
                self.charactersList = []
                self.loading.onNext(true)
            } else {
                self.fetchingMore.onNext(true)
            }
            
            return search
        }.debounce(
            .milliseconds(500),
            scheduler: MainScheduler.instance
        ).flatMap { search -> Observable<CharactersResponse> in
            return self.useCase.characters(
                offset: self.charactersList.count,
                search: search
            )
        }.map { result -> [Character] in
            self.loading.onNext(false)
            self.fetchingMore.onNext(false)
            self.charactersList.append(contentsOf: result.data.results)
            return self.charactersList
        }
        
        let noData = characters.map { $0.count == 0}
        
        fetchMore()
        
        let finalCharacters = Observable.merge(characters, cleanData)
        
        return Output(
            characters: finalCharacters,
            loading: self.loading.asObservable(),
            fetchingMore: self.fetchingMore.asObservable(),
            noData: noData
        )
    }
    
    func fetchMore() {
        self.fetchMoreData.onNext(Void())
    }
}

extension CharactersListViewModel {
    struct Input {
        let search: Driver<String?>
    }
    struct Output {
        let characters: Observable<[Character]>
        let loading: Observable<Bool>
        let fetchingMore: Observable<Bool>
        let noData: Observable <Bool>
    }
}
