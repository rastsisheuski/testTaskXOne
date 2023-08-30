//
//  AppColors.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 30.08.23.
//

import UIKit

enum AppColors: String {
    case backgroundColor = "mainBackground"
    case spinnerColor = "Spinner"
    case spinnerBackgroundColor = "SpinnerBackground"
    case mainTextColor = "mainTextColor"
    
    var value: UIColor {
        switch self {
            case .backgroundColor:          return UIColor(named: rawValue) ?? UIColor()
            case .spinnerColor:             return UIColor(named: rawValue) ?? UIColor()
            case .spinnerBackgroundColor:   return UIColor(named: rawValue) ?? UIColor()
            case .mainTextColor:            return UIColor(named: rawValue) ?? UIColor()
        }
    }
}

