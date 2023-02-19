//
//  RMSettingsCellViewModel.swift
//  RickAndMorty
//
//  Created by Nikita Koniukh on 19/02/2023.
//

import UIKit

struct RMSettingsCellViewModel: Identifiable {
    let id = UUID()
    
    public var image: UIImage? {
        return type.iconImage
    }
    
    public var title: String {
        return type.displayTitle
    }
    
    public var iconContainerColor: UIColor {
        return type.iconContainerColor
    }
    
    public let type: RMSettingsOption
    public let onTapHandler: (RMSettingsOption) -> Void
    
    init(type: RMSettingsOption, onTapHandler: @escaping(RMSettingsOption) -> Void) {
        self.type = type
        self.onTapHandler = onTapHandler
    }
}
