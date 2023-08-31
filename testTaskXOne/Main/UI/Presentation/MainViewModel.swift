//
//  MainViewModel.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 30.08.23.
//

import Foundation
import Combine

final class MainViewModel: CatsListNavigationResponder,
                           SpinnerNavigationResponder {
    
    // MARK: -
    // MARK: - Private Properties
    
    private(set) var isDisplayingSpinner = PassthroughSubject<Bool, Never>()
    private(set) var isDisplayingCatsList = PassthroughSubject<Bool, Never>()
    private(set) var isDisplayingDescription = PassthroughSubject<Bool, Never>()
    
    // MARK: -
    // MARK: - Public Methods
    
    func showCatsList() {
        isDisplayingCatsList.send(true)
    }
    
    func showDescription() {
        isDisplayingDescription.send(true)
    }
    
    func hideDescription() {
        isDisplayingDescription.send(false)
    }
    
    func showSpinner() {
        isDisplayingSpinner.send(true)
    }
    
    func hideSpinner() {
        isDisplayingSpinner.send(false)
    }
}
