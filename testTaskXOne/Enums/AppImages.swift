//
//  AppImages.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 30.08.23.
//

import UIKit

enum AppImages: String {
    case defaultCatImage = "DefaultCatImage"
    
    var value: UIImage {
        switch self {
            case .defaultCatImage:  return UIImage(named: rawValue) ?? UIImage()
        }
    }
}
