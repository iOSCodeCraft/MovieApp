//
//  UIViewController+Extension.swift
//  MovieApp
//
//  Created by manya on 04/03/24.
//

import Foundation
import UIKit

extension UIViewController {
    func showModal(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
