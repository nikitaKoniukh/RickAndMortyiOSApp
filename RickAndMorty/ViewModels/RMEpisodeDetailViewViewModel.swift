//
//  RMEpisodeDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Nikita Koniukh on 11/02/2023.
//

import Foundation

final class RMEpisodeDetailViewViewModel {
    
    private let endPointUrl: URL?
    
    init(endPointUrl: URL?) {
        self.endPointUrl = endPointUrl
        fetchEpisodeData()
    }
    
    
    private func fetchEpisodeData() {
        guard let url = endPointUrl, let request = RMRequest(url: url) else {
            return
        }
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { result in
            switch result {
            case .success(let s):
                print(s)
            case .failure(let error):
                print(error)
            }
        }
    }
}
