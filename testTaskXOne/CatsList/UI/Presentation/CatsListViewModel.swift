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
    
    public private(set) var catsList: [Cat]?
    private(set) var pageNumber: Int = 0
    
    // MARK: -
    // MARK: - Private Properties
    
    private(set) var isLoading = PassthroughSubject<Bool, Never>()
    private(set) var getCatsListSuccess = PassthroughSubject<Bool, Never>()
    private(set) var currentPaginationPage = PassthroughSubject<Int, Never>()
    
    // MARK: -
    // MARK: - Lifecycle
    
    init(catGetter: CatsGetter) {
        self.catGetter = catGetter
    }
    
    // MARK: -
    // MARK: - Public Methods
    
    func getCats(page: Int) {
        isLoading.send(true)
        catGetter.getCats(page: page) { [weak self] result in
            switch result {
                case .success(let cats):
                    if self?.catsList == nil {
                        self?.catsList = cats
                    } else {
                        self?.catsList?.append(contentsOf: cats)
                    }
                    self?.getCatsListSuccess.send(true)
                    self?.isLoading.send(false)
                    self?.incrementPageNumber()
                case .failure(let error):
                    self?.getCatsListSuccess.send(false)
                    self?.isLoading.send(false)
            }
        }
    }
    
    private func incrementPageNumber() {
        pageNumber += 1
        currentPaginationPage.send(pageNumber)
    }
}
