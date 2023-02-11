//
//  RMGetEpisodesResponse.swift
//  RickAndMorty
//
//  Created by Nikita Koniukh on 11/02/2023.
//

import Foundation

struct RMGetEpisodesResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [RMEpisode]
}
