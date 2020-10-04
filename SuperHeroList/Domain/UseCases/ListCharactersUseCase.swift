//
//  CharactersUseCase.swift
//  Domain
//
//  Created by Tiago Pereira on 28/09/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation
import RxSwift

/// Protocol to be used in the api in order to know which functions do we want to cover for
/// for character list use case
public protocol ListCharactersUseCase {
    func characters(offset: Int, search: String?) -> Observable<CharactersResponse>
}
