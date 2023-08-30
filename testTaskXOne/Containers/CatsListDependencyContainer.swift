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
            self.createCatsListViewController(spinnerNavigationResponder: sharedViewModel, descriptionNavigationResponder: sharedViewModel)
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
    
    private func createCatsListViewController(spinnerNavigationResponder: SpinnerNavigationResponder, descriptionNavigationResponder: DescriptionNavigationResponder) -> CatsListViewController {
        let viewModel = createCatsListViewModel()
        let safariPresenter = createSafariPresenter()
        
        return CatsListViewController(viewModel: viewModel,
                                      safariPresenter: safariPresenter,
                                      spinnerNavigationResponder: spinnerNavigationResponder,
                                      descriptionNavigationResponder: descriptionNavigationResponder)
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
    
    private func createSafariPresenter() -> SafariPresenter {
        return SafariPresenter()
    }
}
