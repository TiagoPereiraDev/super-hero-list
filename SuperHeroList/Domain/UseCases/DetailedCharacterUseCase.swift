//
//  CharacterUseCase.swift
//  Domain
//
//  Created by Tiago Pereira on 02/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation
import RxSwift

public protocol DetailedCharacterUseCase {
    func comics(offset: Int, characterId: Double) -> Observable<ComicsResponse>
    func series(offset: Int, characterId: Double) -> Observable<SeriesResponse>
    func stories(offset: Int, characterId: Double) -> Observable<StoriesResponse>
    func events(offset: Int, characterId: Double) -> Observable<EventsResponse>
}
