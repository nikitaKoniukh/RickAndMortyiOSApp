//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Nikita Koniukh on 11/02/2023.
//

import UIKit

final class RMEpisodeDetailViewController: UIViewController {

    private let viewModel: RMEpisodeDetailViewViewModel?
    private let detailView = RMEpisodeDetailView()
    
    init(url: URL?) {
        self.viewModel = RMEpisodeDetailViewViewModel(endPointUrl: url)
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        title = "Episode"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        detailView.delegate = self
        viewModel?.delegate = self
        viewModel?.fetchEpisodeData()
    }
    
    fileprivate func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(detailView)
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    @objc
    private func didTapShare() {
        
    }
}

extension RMEpisodeDetailViewController: RMEpisodeDetailViewViewModelDelegate {
    func didFetchEpisodeDetails() {
        detailView.configure(with: viewModel)
    }
}

extension RMEpisodeDetailViewController: RMEpisodeDetailViewDelegate {
    func rmEpisodeDetailView(_ detailView: RMEpisodeDetailView, didSelectCharacter: RMCharacter) {
        let vc  = RMCharacterDetailViewController(viewModel: .init(character: didSelectCharacter))
        vc.title = didSelectCharacter.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
