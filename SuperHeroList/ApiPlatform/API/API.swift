//
//  API.swift
//  ApiPlatform
//
//  Created by Tiago Pereira on 30/09/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation
import Domain
import RxAlamofire
import RxSwift

public class API {
    
    static let cache = NSCache<NSString, NSData>()
    
    // Computed property to build the base path in order to make calls to the Marvel API
    private static var basePath: String {
        return "\(MarvelConstants.basePath)/\(MarvelConstants.apiVersion)/\(MarvelConstants.publicApi)"
    }
    
    public static func buildCharactersUseCase() -> CharactersUseCase {
        return CharactersUseCase(endpoint: basePath)
    }
    
    public static func buildCharacterUseCase(character: Character) -> CharacterUseCase {
        return CharacterUseCase(endpoint: "\(basePath)/characters/\(character.id)")
    }
    
    public static func fetchImage(thumbnail: Thumbnail?) -> Observable<UIImage?> {

        guard let thumbnail = thumbnail,
            let url = URL(string: "\(thumbnail.path).\(thumbnail.ext)") else {
            return Observable.just(nil)
        }
        
        if let data = self.cache.object(forKey: "\(thumbnail.path).\(thumbnail.ext)" as NSString) {
            return Observable.just(UIImage(data: data as Data))
        }
        
        
        return RxAlamofire.request(.get, url).data().map { data -> UIImage? in
            guard let normalImage = UIImage(data: data) else {
                return nil
            }
            
            if let lowCompressionImage = normalImage.jpegData(compressionQuality: 0) {
                self.cache.setObject(
                    lowCompressionImage as NSData,
                    forKey: "\(thumbnail.path).\(thumbnail.ext)" as NSString
                )
                return UIImage(data: lowCompressionImage)
            }
            
            return normalImage
        }
    }
    
}
