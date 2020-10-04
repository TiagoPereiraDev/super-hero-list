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

// Class that follow the facade pattern principles, where all the API logic (Network, Cache, Use Case builds) are hidden in the same class
public class API {
    static let cache = CacheHandler<NSData>()
    
    // Computed property to build the base path in order to make calls to the Marvel API
    private static var basePath: String {
        return "\(MarvelConstants.basePath)/\(MarvelConstants.apiVersion)/\(MarvelConstants.publicApi)"
    }
    
    /**
    static method to build characters use case to be used in the CharactersListViewController

    - Returns: use case for characters
    */
    public static func buildCharactersUseCase() -> CharactersUseCase {
        return CharactersUseCase(endpoint: basePath)
    }
    
    /**
    static method to build characters use case to be used in the DetailedCharacterViewController

    - Parameter character: character used for this use case

    - Returns: use case for the character sent by parameter
    */
    public static func buildCharacterUseCase(character: Character) -> CharacterUseCase {
        return CharacterUseCase(endpoint: "\(basePath)/characters/\(character.id)")
    }
    
    /**
    static method to fetch an image from a thumbnail, it also handles the images cache

    - Parameter thumbnail: thumbnail with the data about the image to be fetched

    - Returns: Observable with the fetched image or nil case no thumbnail available
    */
    public static func fetchImage(thumbnail: Thumbnail?) -> Observable<UIImage?> {
        
        guard let thumbnail = thumbnail else {
            return Observable.just(nil)
        }
        
        let path = "\(thumbnail.path).\(thumbnail.ext)"

        guard let url = URL(string: path) else {
            return Observable.just(nil)
        }
        
        if let data = self.cache.getData(key: path) as Data? {
            return Observable.just(UIImage(data: data as Data))
        }
        
        
        return RxAlamofire.request(.get, url).data().map { data -> UIImage? in
            guard let normalImage = UIImage(data: data) else {
                return nil
            }
            
            if let lowCompressionImage = normalImage.jpegData(compressionQuality: 0) {
                self.cache.saveData( key: path, value: lowCompressionImage as NSData)
                
                return UIImage(data: lowCompressionImage)
            }
            
            return normalImage
        }
    }
    
}
