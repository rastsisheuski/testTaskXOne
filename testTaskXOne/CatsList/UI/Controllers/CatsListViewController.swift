//
//  CatsListViewController.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 29.08.23.
//

import UIKit

final class CatsListViewController: NiblessViewController {
    
    // MARK: -
    // MARK: - Private methods
    
    private var contentView: CatsListViewControllerView {
        view as! CatsListViewControllerView
    }
    
    private let viewModel: CatsListViewModel
    
    init(viewModel: CatsListViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: -
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        
        view = CatsListViewControllerView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getCats()
    }
}
