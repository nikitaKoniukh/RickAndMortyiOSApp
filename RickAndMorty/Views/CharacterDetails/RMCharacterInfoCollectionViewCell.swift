//
//  RMCharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Nikita Koniukh on 07/02/2023.
//

import UIKit

final class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterInfoCollectionViewCell"
    
    private var viewModel: RMCharacterInfoCollectionViewCellViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: RMCharacterInfoCollectionViewCellViewModel) {
        self.viewModel = viewModel
    }
}
