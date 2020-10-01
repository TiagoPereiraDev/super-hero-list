//
//  CharactersListViewModel.swift
//  SuperHeroList
//
//  Created by Tiago Pereira on 30/09/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation
import Domain

class CharactersListViewModel: ViewModelType {
    
    let useCase: ListCharactersUseCase
    
    init(useCase : ListCharactersUseCase) {
        self.useCase = useCase
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
    

}

extension CharactersListViewModel {
    struct Input {}
    struct Output {}
}
