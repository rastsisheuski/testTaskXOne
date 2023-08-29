//
//  DescriptionViewController.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 30.08.23.
//

import Foundation

final class DescriptionViewController: NiblessViewController {
    
    // MARK: -
    // MARK: - Private Properties
    
    private var contentView: DescriptionViewControllerView {
        view as! DescriptionViewControllerView
    }
    
    // MARK: -
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        
        view = DescriptionViewControllerView()
    }
    
}
