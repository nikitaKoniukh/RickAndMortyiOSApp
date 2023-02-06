//
//  RMImageLoader.swift
//  RickAndMorty
//
//  Created by Nikita Koniukh on 06/02/2023.
//

import Foundation

final class RMImageLoader {
    static let shared = RMImageLoader()
    
    private var imageDataCache = NSCache<NSString, NSData>()
    
    private init(){}
    
    func downloadImage(_ url: URL, complition: @escaping(Result<Data, Error>) -> Void) {
        let key = url.absoluteString as NSString
        if let data = imageDataCache.object(forKey: key) {
            complition(.success(data as Data))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil  else {
                complition(.failure(URLError(.badServerResponse)))
                return
            }
            
            let value = data as NSData
            self?.imageDataCache.setObject(value, forKey: key)
            
            complition(.success(data))
        }
        task.resume()
    }
}
