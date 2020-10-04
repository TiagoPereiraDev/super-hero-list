//
//  ChacheHandler.swift
//  ApiPlatform
//
//  Created by Tiago Pereira on 04/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation

/// Class the will help to handle all the cache used by this api save, clean and get data from cache
internal class CacheHandler<T: AnyObject>  {
    let cache: NSCache<NSString, T>
    
    public init() {
        cache = NSCache()
    }
    
    /**
     Method to get data that is saved in cache with this key if any
     
     - Parameter key: key where data is saved in cache
     
     - Returns: Data related to the key case any
     */
    public func getData(key: String) -> T? {
        return self.cache.object(forKey: key as NSString)
    }
    
    /**
     Method to save data in cache linked to a key
     
     - Parameter key: key where data is to be saved in cache
     */
    public func saveData(key: String, value: T) {
        return self.cache.setObject(value, forKey: key as NSString)
    }
    
    /**
     Method to clean cache entry with this key
     
     - Parameter key: key where data is saved in cache
     */
    public func cleanData(key: String) {
        return self.cache.removeObject(forKey: key as NSString)
    }
    
    /**
     Method to clean all entries from cache
     */
    public func cleanAllData() {
        return self.cache.removeAllObjects()
    }
}
