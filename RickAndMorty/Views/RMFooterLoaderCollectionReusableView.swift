//
//  RMFooterLoaderCollectionReusableView.swift
//  RickAndMorty
//
//  Created by Nikita Koniukh on 02/02/2023.
//

import UIKit

final class RMFooterLoaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "RMFooterLoaderCollectionReusableView"
    
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(spinner)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
    }
    
    public func startAnimating() {
        spinner.startAnimating()
    }
}
