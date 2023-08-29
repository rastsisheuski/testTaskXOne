//
//  CatsListDependencyContainer.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 29.08.23.
//

import Foundation

class CatsListDependencyContainer {
    
    // MARK: -
    // MARK: - Public Methods
    
    func makeMainViewController() -> MainViewController {
        
        let catsListViewControllerFactory = {
            self.createCatsListViewController()
        }
        
        return MainViewController(catsListViewControllerFactory: catsListViewControllerFactory)
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func createCatsListViewController() -> CatsListViewController {
        let viewModel = createCatsListViewModel()
        
        return CatsListViewController(viewModel: viewModel)
    }
    
    private func createCatsListViewModel() -> CatsListViewModel {
        let catsGetter = createCatsGetter()
        
        return CatsListViewModel(catGetter: catsGetter)
    }
    
    private func createCatsGetter() -> CatsGetter {
        let httpClient = URLSessionNetworkingHTTPClient()
        let catsRemote = CatsListRemoteAPI(httpClient: httpClient)
        let catsRepository = CatsListRepository(catsListRemoteAPI: catsRemote)
        
        return catsRepository
    }
}
