//
//  RMEpisodeViewController.swift
//  RickAndMorty
//
//  Created by Nikita Koniukh on 24/01/2023.
//

import UIKit

final class RMEpisodeViewController: UIViewController {

    private let episodeListView = RMEpisodeListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Episodes"
        setupView()
    }
    
    private func setupView() {
        episodeListView.delegate = self
        view.addSubview(episodeListView)
        NSLayoutConstraint.activate([
            episodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            episodeListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            episodeListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
}

extension RMEpisodeViewController: RMEpisodeListViewDelegate {
    func rmEpisodesListView(_ episodeListView: RMEpisodeListView, didselectEpisode episode: RMEpisode) {
        let url = URL(string: episode.url)
        let detailVC = RMEpisodeDetailViewController(url: url)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
