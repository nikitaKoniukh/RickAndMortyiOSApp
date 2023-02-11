//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Nikita Koniukh on 11/02/2023.
//

import UIKit

final class RMEpisodeDetailViewController: UIViewController {

    private let viewModel: RMEpisodeDetailViewViewModel?
    
    init(url: URL?) {
        self.viewModel = RMEpisodeDetailViewViewModel(endPointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.backgroundColor = .systemGreen
    }
}
