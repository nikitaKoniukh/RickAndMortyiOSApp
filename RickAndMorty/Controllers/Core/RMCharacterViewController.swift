//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Nikita Koniukh on 24/01/2023.
//

import UIKit

final class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        
        RMService.shared.execute(.listCharacters, expecting: RMGetCharactersResponse.self, completion: { result in
            switch result {
            case .success(let model):
                print("\(model.info.count)")
            case .failure(let error):
                print(String(describing: error))
            }
        })
    }
}
 
