//
//  RMGetCharactersResponse.swift
//  RickAndMorty
//
//  Created by Nikita Koniukh on 30/01/2023.
//

import Foundation

struct RMGetCharactersResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [RMCharacter]
}
