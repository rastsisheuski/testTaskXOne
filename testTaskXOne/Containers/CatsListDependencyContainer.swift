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
            self.createCatsListViewController(spinnerNavigationResponder: sharedViewModel)
        }
        
        return MainViewController(viewModel: sharedViewModel,
                                  catsListViewControllerFactory: catsListViewControllerFactory,
                                  spinnerViewControllerFactory: spinnerViewcontrollerFactory,
                                  currentWindow: sharedWindow)
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func createSpinnerViewController() -> SpinnerViewController {
        return SpinnerViewController()
    }
    
    private func createCatsListViewController(spinnerNavigationResponder: SpinnerNavigationResponder) -> CatsListViewController {
        let viewModel = createCatsListViewModel()
        let safariPresenter = createSafariPresenter()
        let alertPresenter = createAlertPresenter()
        
        return CatsListViewController(viewModel: viewModel,
                                      alertPresenter: alertPresenter,
                                      safariPresenter: safariPresenter,
                                      spinnerNavigationResponder: spinnerNavigationResponder)
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
    
    private func createMainViewModel() -> MainViewModel {
        return MainViewModel()
    }
    
    private func createSafariPresenter() -> SafariPresenter {
        return SafariPresenter()
    }
    
    private func createAlertPresenter() -> AlertPresenter {
        return AlertPresenter()
    }
}
