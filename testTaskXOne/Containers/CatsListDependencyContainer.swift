//
//  CatsListDependencyContainer.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 29.08.23.
//

import UIKit

class CatsListDependencyContainer {
    
    let sharedWindow: UIWindow
    
    // MARK: -
    // MARK: - Lifecycle
    
    init(sharedWindow: UIWindow) {
        self.sharedWindow = sharedWindow
    }
    
    // MARK: -
    // MARK: - Public Methods
    
    func makeMainViewController() -> MainViewController {
        
        let sharedViewModel = createMainViewModel()
        
        let spinnerViewcontrollerFactory =  {
            self.createSpinnerViewController()
        }
        let catsListViewControllerFactory = {
            self.createCatsListViewController()
        }
        let descriptionViewControllerFactory = {
            self.createDescriptionViewController()
        }
        
        return MainViewController(viewModel: sharedViewModel,
                                  catsListViewControllerFactory: catsListViewControllerFactory,
                                  descriptionViewControllerFactory: descriptionViewControllerFactory,
                                  spinnerViewControllerFactory: spinnerViewcontrollerFactory,
                                  currentWindow: sharedWindow)
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func createSpinnerViewController() -> SpinnerViewController {
        return SpinnerViewController()
    }
    
    private func createCatsListViewController() -> CatsListViewController {
        let viewModel = createCatsListViewModel()
        
        return CatsListViewController(viewModel: viewModel)
    }
    
    private func createCatsListViewModel() -> CatsListViewModel {
        let catsGetter = createCatsGetter()
        
        return CatsListViewModel(catGetter: catsGetter)
    }
    
    private func createDescriptionViewController() -> DescriptionViewController {
        return DescriptionViewController()
    }
    
    private func createCatsGetter() -> CatsGetter {
        let httpClient = URLSessionNetworkingHTTPClient()
        let catsRemote = CatsListRemoteAPI(httpClient: httpClient)
        let catsRepository = CatsListRepository(catsListRemoteAPI: catsRemote)
        
        return catsRepository
    }
    
    private func createMainViewModel() -> MainViewModel {
        return MainViewModel()
    }
}
