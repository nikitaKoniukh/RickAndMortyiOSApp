//
//  RMService.swift
//  RickAndMorty
//
//  Created by Nikita Koniukh on 24/01/2023.
//

import Foundation

final class RMService {
    static let shared = RMService()
    
    private init(){}
    
    public func execute(_ request: RMRequest, completion: @escaping () -> Void) {
        
    }
}
