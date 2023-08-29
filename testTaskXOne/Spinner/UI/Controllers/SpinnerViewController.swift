//
//  SpinnerViewController.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 30.08.23.
//

import Foundation

final class SpinnerViewController: NiblessViewController {
    
    // MARK: -
    // MARK: - Private Properties
    
    private var contentView: SpinnerViewControllerView {
        view as! SpinnerViewControllerView
    }
    
    // MARK: -
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        
        view = SpinnerViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.activityIndicator.startAnimating()
    }
}
