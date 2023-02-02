//
//  RMCharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Nikita Koniukh on 31/01/2023.
//

import UIKit

protocol RMCharacterListViewViewModelDelegate: AnyObject  {
    func didLoadInitialCharacters()
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath])
    func didSelectChareacter(_ character: RMCharacter)
}

class RMCharacterListViewViewModel: NSObject {
    
    public weak var delegate: RMCharacterListViewViewModelDelegate?
    
    private var isLoadingMoreCharacters = false
    
    private var characters: [RMCharacter] = [] {
        didSet {
            for character in characters {
                let viewModel = RMCharecterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image)
                )
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    private var cellViewModels: [RMCharecterCollectionViewCellViewModel] = []
    
    private var apiInfo: RMGetCharactersResponse.Info? = nil
    
    public func fetchCharacters() {
        RMService.shared.execute(.listCharacters, expecting: RMGetCharactersResponse.self, completion: { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info
                self?.apiInfo = info
                self?.characters = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        })
    }
    
    public func fetchAditionalCharacters(url: URL) {
        guard !isLoadingMoreCharacters else {
            return
        }
        
        isLoadingMoreCharacters = true
        guard let request = RMRequest(url: url) else {
            isLoadingMoreCharacters = false
            return
        }
        
        RMService.shared.execute(request, expecting: RMGetCharactersResponse.self) { [weak self] result  in
            guard let strongSelf = self else {
                return
            }
            
            switch result {
            case .success(let responseModel):
                let moreResults = responseModel.results
                let info = responseModel.info
                strongSelf.apiInfo = info
                let originalCount = strongSelf.characters.count
                let newCount = moreResults.count
                let totlal = originalCount + newCount
                let startingIndex = totlal - newCount
                let indexPathToAdd: [IndexPath] = Array(startingIndex..<(startingIndex + newCount)).compactMap({
                    return IndexPath(item: $0, section: 0)
                })
                
                strongSelf.characters.append(contentsOf: moreResults)
                DispatchQueue.main.async {
                    
                    strongSelf.delegate?.didLoadMoreCharacters(with: indexPathToAdd)
                    strongSelf.isLoadingMoreCharacters = false
                }
            case .failure(let error):
                self?.isLoadingMoreCharacters = false
                print(error)
            }
        }
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
}

extension RMCharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.charachterCellId, for: indexPath) as? RMCharacterCollectionViewCell else {
            fatalError("Unsuported cell")
        }
        
        let viewModel = cellViewModels[indexPath.item]
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.item]
        delegate?.didSelectChareacter(character)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionFooter,
              shouldShowLoadMoreIndicator,
              let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RMFooterLoaderCollectionReusableView.identifier, for: indexPath) as? RMFooterLoaderCollectionReusableView else {
            fatalError("Unsuported")
        }
        
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

extension RMCharacterListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreCharacters,
              !cellViewModels.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else {
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                self?.fetchAditionalCharacters(url: url)
            }
            
            t.invalidate()
        })
        
    }
}

