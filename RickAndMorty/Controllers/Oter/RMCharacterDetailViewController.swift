//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Nikita Koniukh on 01/02/2023.
//

import UIKit

class RMCharacterDetailViewController: UIViewController {

    private var viewModel: RMCharacterDetailsViewViewModel
    
    init(viewModel: RMCharacterDetailsViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
}
