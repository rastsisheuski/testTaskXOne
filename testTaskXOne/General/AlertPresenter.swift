//
//  AlertPresenter.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 30.08.23.
//

import UIKit

final class AlertPresenter {
    
    private var window: UIWindow!
    
    func presentAlert(on viewController: NiblessViewController,error: Error, message: String) {
        let title = error.localizedDescription
        let message = message
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: false)
    }
}
