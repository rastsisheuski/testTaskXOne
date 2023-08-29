//
//  CatsListRepository.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 29.08.23.
//

import Foundation

final class CatsListRepository: CatsGetter {
    
    // MARK: -
    // MARK: - Private Properties
    
    private let catsListRemoteAPI: CatsListRemoteAPI
    
    // MARK: -
    // MARK: - Lifecycle
    
    init(catsListRemoteAPI: CatsListRemoteAPI) {
        self.catsListRemoteAPI = catsListRemoteAPI
    }
    
    // MARK: -
    // MARK: - Public Methods
    
    func getCats(completion: @escaping (Result<[Cat], Error>) -> Void) {
        catsListRemoteAPI.getCats(completion: completion)
    }
}
