//
//  RMCharacterDetailsViewViewModel.swift
//  RickAndMorty
//
//  Created by Nikita Koniukh on 01/02/2023.
//

import UIKit

class RMCharacterDetailsViewViewModel {
    private let character: RMCharacter
    
    enum SectionType {
        case photo(viewModel: RMCharacterPhotoCollectionViewCellViewModel)
        case information(viewModel: [RMCharacterInfoCollectionViewCellViewModel])
        case episodes(viewModel: [RMCharacterEpisodeCollectionViewCellViewModel])
    }
    
    public var sections = [SectionType]()
    
    init(character: RMCharacter) {
        self.character = character
        setupSections()
    }
    
    private func setupSections() {
        sections = [
            .photo(viewModel: .init()),
            .information(viewModel: [
                .init(),
                .init(),
                .init(),
                .init()
            ]),
            .episodes(viewModel: [
                .init(),
                .init(),
                .init(),
                .init(),
                .init(),
                .init(),
                .init(),
            ])
        ]
        
    }
    
    private var requestUrl: URL? {
        return URL(string: character.url)
    }
    
    public var title: String {
        return character.name.uppercased()
    }

    public func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize:
                                            NSCollectionLayoutSize(widthDimension:
                                                    .fractionalWidth(1.0), heightDimension:
                                                    .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize:
                                                        NSCollectionLayoutSize(widthDimension:
                                                                .fractionalWidth(1.0), heightDimension:
                                                                .fractionalHeight(0.5)),
                                                     subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createInformationSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize:
                                            NSCollectionLayoutSize(widthDimension:
                                                    .fractionalWidth(0.5), heightDimension:
                                                    .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize:
                                                        NSCollectionLayoutSize(widthDimension:
                                                                .fractionalWidth(1.0), heightDimension:
                                                                .absolute(150)),
                                                     subitems: [item, item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createEpisodesSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize:
                                            NSCollectionLayoutSize(widthDimension:
                                                    .fractionalWidth(1.0), heightDimension:
                                                    .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2, bottom: 10, trailing: 2)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize:
                                                        NSCollectionLayoutSize(widthDimension:
                                                                .fractionalWidth(0.8), heightDimension:
                                                                .absolute(150)),
                                                     subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
