//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Nikita Koniukh on 31/01/2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
