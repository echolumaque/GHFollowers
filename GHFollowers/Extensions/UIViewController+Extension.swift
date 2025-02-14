//
//  UIViewController+Extension.swift
//  GHFollowers
//
//  Created by Echo Lumaque on 2/14/25.
//

import UIKit

extension UIViewController {
    
    @MainActor
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        let alertVC = GFAlertViewController(
            alertTitle: title,
            message: message,
            buttonTitle: buttonTitle
        )
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
}
