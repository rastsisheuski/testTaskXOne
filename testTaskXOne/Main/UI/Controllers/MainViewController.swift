//
//  MainViewController.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 29.08.23.
//

import UIKit

final class MainViewController: NiblessViewController {
    
    private let catsListViewControllerFactory: () -> CatsListViewController
    
    init(catsListViewControllerFactory: @escaping () -> CatsListViewController) {
        self.catsListViewControllerFactory = catsListViewControllerFactory
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentCatsListViewController()
    }
    
    private func presentCatsListViewController() {
        let catsListViewController = catsListViewControllerFactory()
        addFullScreen(childViewController: catsListViewController)
    }
}
