//
//  CatsListViewModel.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 29.08.23.
//

import Foundation
import Combine

final class CatsListViewModel {
    
    // MARK: -
    // MARK: - Public Properties
    
    let catGetter: CatsGetter
    
    // MARK: -
    // MARK: - Private Properties
    
    private(set) var isGettingCats = PassthroughSubject<Bool, Never>()
    
    // MARK: -
    // MARK: - Lifecycle
    
    init(catGetter: CatsGetter) {
        self.catGetter = catGetter
    }
    
    // MARK: -
    // MARK: - Public Methods
    
    func getCats() {
        catGetter.getCats { result in
            switch result {
                case .success(let cats):
                    self.isGettingCats.send(true)
                case .failure(let error):
                    self.isGettingCats.send(false)
            }
        }
    }
}
