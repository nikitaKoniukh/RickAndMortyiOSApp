//
//  RMCharecterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Nikita Koniukh on 31/01/2023.
//

import Foundation

class RMCharecterCollectionViewCellViewModel: Hashable, Equatable {
    
    public let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImageUrl: URL?
    
    static func == (lhs: RMCharecterCollectionViewCellViewModel, rhs: RMCharecterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageUrl)
    }
    
    init(characterName: String, characterStatus: RMCharacterStatus, characterImageUrl: URL?) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }

    public var characterStatusText: String {
        return "Status: \(characterStatus.text)"
    }
    
    public func fetchImage(complition: @escaping(Result<Data, Error>) -> Void) {
        guard let characterImageUrl = characterImageUrl else {
            complition(.failure(URLError(.badURL)))
            return
        }
        RMImageLoader.shared.downloadImage(characterImageUrl, complition: complition)
    }
}
