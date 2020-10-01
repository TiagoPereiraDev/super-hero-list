//
//  CharactersUseCase.swift
//  Domain
//
//  Created by Tiago Pereira on 28/09/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation
import RxSwift

public protocol ListCharactersUseCase {
    func characters(offset: Int) -> Observable<CharactersResponse>
}
