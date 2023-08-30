//
//  SpinnerViewControllerView.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 30.08.23.
//

import UIKit

final class SpinnerViewControllerView: UIView {
    
    // MARK: -
    // MARK: - Public Properties
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let spinnerView = UIActivityIndicatorView()
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        spinnerView.color = AppColors.spinnerColor.value
        spinnerView.style = .large
        return spinnerView
    }()
    
    // MARK: -
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func setupView() {
        backgroundColor = AppColors.spinnerBackgroundColor.value
    }
    
    private func layoutElements() {
        layoutActivityIndicator()
    }
    
    private func layoutActivityIndicator() {
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
