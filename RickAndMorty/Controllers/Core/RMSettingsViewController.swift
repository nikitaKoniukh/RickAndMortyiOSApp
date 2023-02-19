//
//  RMSettingsViewController.swift
//  RickAndMorty
//
//  Created by Nikita Koniukh on 24/01/2023.
//

import StoreKit
import UIKit
import SwiftUI
import SafariServices

final class RMSettingsViewController: UIViewController {
    
    private var settingsSwiftUIController: UIHostingController<RMSettingsView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Settings"
        addSwiftUIController()
    }
    
    private func addSwiftUIController() {
        let settingsSwiftUIController = UIHostingController(rootView: RMSettingsView(viewModel: RMSettingsViewViewModel(cellViewModels: RMSettingsOption.allCases.compactMap({
            return RMSettingsCellViewModel(type: $0, onTapHandler: { [weak self] option in
                self?.handleTap(option: option)
            })
        }))))
        
        addChild(settingsSwiftUIController)
        settingsSwiftUIController.didMove(toParent: self)
        
        view.addSubview(settingsSwiftUIController.view)
        settingsSwiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsSwiftUIController.view.topAnchor.constraint(equalTo: view.topAnchor),
            settingsSwiftUIController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            settingsSwiftUIController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            settingsSwiftUIController.view.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
    }
    
    private func handleTap(option: RMSettingsOption) {
        guard Thread.current.isMainThread else {
            return
        }
        
        if let url = option.targetUrl {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        } else {
            if let windowScene = view.window?.windowScene {
                SKStoreReviewController.requestReview(in: windowScene)
            }
        }
    }
}

