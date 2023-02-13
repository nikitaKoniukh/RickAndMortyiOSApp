//
//  RMEpisodeDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Nikita Koniukh on 11/02/2023.
//

import Foundation

protocol RMEpisodeDetailViewViewModelDelegate: AnyObject {
    func didFetchEpisodeDetails()
}

final class RMEpisodeDetailViewViewModel {
    private let endPointUrl: URL?
    weak public var delegate: RMEpisodeDetailViewViewModelDelegate?
    private var dataTuple: (episode: RMEpisode, characters: [RMCharacter])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchEpisodeDetails()
        }
    }
    
    enum SectionType {
        case information(viewModels: [RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModels: [RMCharecterCollectionViewCellViewModel])
    }
    
    public private(set) var cellViewModels: [SectionType] = []
    
    init(endPointUrl: URL?) {
        self.endPointUrl = endPointUrl
    }
    
    private func createCellViewModels() {
        guard let dataTuple = dataTuple else {
            return
        }
        
        let episode = dataTuple.episode
        let characters = dataTuple.characters
        
        cellViewModels = [
            .information(viewModels: [
                .init(title: "Episode Name", value: episode.name),
                .init(title: "Air Date", value: episode.air_date),
                .init(title: "Episode", value: episode.episode),
                .init(title: "Created", value: episode.created),
            ]),
            .characters(viewModels: characters.compactMap({ character in
                    return RMCharecterCollectionViewCellViewModel(characterName: character.name,
                                                                  characterStatus: character.status,
                                                                  characterImageUrl: URL(string: character.image))
                })
            )
        ]
    }
    
    public func fetchEpisodeData() {
        guard let url = endPointUrl, let request = RMRequest(url: url) else {
            return
        }
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.fetchRelatedCharacters(episode: model)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchRelatedCharacters(episode: RMEpisode) {
        let requests = episode.characters.compactMap({
            return URL(string: $0)
        }).compactMap({
            return RMRequest(url: $0)
        })
        
        let group = DispatchGroup()
        var characters = [RMCharacter]()
        for request in requests {
            group.enter()
            RMService.shared.execute(request, expecting: RMCharacter.self, completion: { result in
                defer {
                    group.leave()
                }
                
                switch result {
                case .success(let character):
                    characters.append(character)
                case .failure(_):
                    break
                }
            })
        }
        
        group.notify(queue: .main, execute: {
            self.dataTuple = (
                episode: episode,
                characters: characters
            )
        })
        
    }
}
