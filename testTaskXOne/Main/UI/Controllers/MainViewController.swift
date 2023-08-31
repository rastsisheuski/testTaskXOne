//
//  MainViewController.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 29.08.23.
//

import UIKit
import Combine

final class MainViewController: NiblessViewController {
    
    // MARK: -
    // MARK: - Public Properties
    
    let viewModel: MainViewModel
    
    // MARK: -
    // MARK: - Private Methods
    
    private let catsListViewControllerFactory: () -> CatsListViewController
    private let spinnerViewControllerFactory: () -> SpinnerViewController
    private let currentNavigationController = UINavigationController()
    
    private var cancellable = Set<AnyCancellable>()
    private var currentWindow: UIWindow!
    
    // MARK: -
    // MARK: - Lifecycle
    
    init(viewModel: MainViewModel,
         catsListViewControllerFactory: @escaping () -> CatsListViewController,
         spinnerViewControllerFactory: @escaping () -> SpinnerViewController,
         currentWindow: UIWindow) {
        self.viewModel = viewModel
        self.catsListViewControllerFactory = catsListViewControllerFactory
        self.spinnerViewControllerFactory = spinnerViewControllerFactory
        self.currentWindow = currentWindow
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentCatsListViewController()
        bindViewModel()
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func bindViewModel() {
        viewModel.isDisplayingSpinner.receive(on: DispatchQueue.main).sink { [weak self] needDisplaySpinner in
            if needDisplaySpinner {
                self?.presentSpinner()
            } else {
                self?.hideSpinner()
            }
        }.store(in: &cancellable)
        
        viewModel.isDisplayingCatsList.receive(on: DispatchQueue.main).sink { [weak self] needDisplayCatsList in
            if needDisplayCatsList {
                self?.presentCatsListViewController()
            }
        }.store(in: &cancellable)
    }
    
    private func presentCatsListViewController() {
        let catsListViewController = catsListViewControllerFactory()
        addFullScreenWithSafeArea(childViewController: currentNavigationController)
        currentNavigationController.viewControllers = [catsListViewController]
    }
    
    private func presentSpinner() {
        let windowScene = UIApplication.shared.connectedScenes.first
        guard let windowScene = windowScene as? UIWindowScene else { return }
        currentWindow = UIWindow(windowScene: windowScene)
        let vc = SpinnerViewController()
        currentWindow.rootViewController = vc
        currentWindow.windowLevel = UIWindow.Level.alert + 1
        currentWindow.makeKeyAndVisible()
    }
    
    private func hideSpinner() {
        currentWindow = nil
    }
}
