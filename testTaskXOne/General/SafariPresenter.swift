//
//  SafariPresenter.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 30.08.23.
//

import UIKit
import SafariServices

final class SafariPresenter {
    
    private var window: UIWindow!
    
    func showSafari(on viewController: CatsListViewController, urlString: String) {
        if let url = URL(string: urlString) {
            let safariViewController = SFSafariViewController(url: url)
            safariViewController.delegate = viewController
            
            let windowScene = UIApplication.shared.connectedScenes.first
            guard let windowScene = windowScene as? UIWindowScene else { return }
            window = UIWindow(windowScene: windowScene)
            window.rootViewController = safariViewController
            window.windowLevel = UIWindow.Level.alert + 1
            window.makeKeyAndVisible()
        }
    }
    
    func dismissSafari(on viewController: CatsListViewController) {
        window = nil
    }
}
