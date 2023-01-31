//
//  RMCharecterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Nikita Koniukh on 31/01/2023.
//

import Foundation

class RMCharecterCollectionViewCellViewModel {
    
    public let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImageUrl: URL?
    
    init(characterName: String, characterStatus: RMCharacterStatus, characterImageUrl: URL?) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }

    public var characterStatusText: String {
        return characterStatus.rawValue
    }
    
    public func fetchImage(complition: @escaping(Result<Data, Error>) -> Void) {
        guard let characterImageUrl = characterImageUrl else {
            complition(.failure(URLError(.badURL)))
            return
        }
        
        let request = URLRequest(url: characterImageUrl)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil  else {
                complition(.failure(URLError(.badServerResponse)))
                return
            }
            complition(.success(data))
        }
        task.resume()
    }
}
