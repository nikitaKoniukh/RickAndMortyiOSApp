//
//  RMApiCacheManager.swift
//  RickAndMorty
//
//  Created by Nikita Koniukh on 10/02/2023.
//

import Foundation

final class RMApiCacheManager {
    
    private var cachedDictionary: [RMEndPoint: NSCache<NSString, NSData>] = [:]
    
    init() {
        setupCache()
    }
    
    // MARK: - public
    public func cachedResponse(with endPoint: RMEndPoint, url: URL?) -> Data? {
        guard let cache = cachedDictionary[endPoint], let key = url?.absoluteString else {
            return nil
        }
        
        let data = cache.object(forKey: key as NSString) as? Data
        return data
    }
    
    public func setCache(with endPoint: RMEndPoint, url: URL?, data: Data?) {
        guard let key = url?.absoluteString, let data = data else {
            return
        }
        
        let cache = cachedDictionary[endPoint]
        cache?.setObject(data as NSData, forKey: key as NSString)
    }
        
    // MARK: - private
    private func setupCache() {
        RMEndPoint.allCases.forEach { enpoint in
            cachedDictionary[enpoint] = NSCache<NSString, NSData>()
        }
    }
    
}
