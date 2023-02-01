//
//  RMCharacterDetailsViewViewModel.swift
//  RickAndMorty
//
//  Created by Nikita Koniukh on 01/02/2023.
//

import Foundation

class RMCharacterDetailsViewViewModel {
    private let character: RMCharacter
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    public var title: String {
        return character.name.uppercased()
    }
}
