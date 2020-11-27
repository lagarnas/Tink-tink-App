//
//  UIViewController + Extension.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 27.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class func loadFromStoryboard<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? T {
            return viewController
        } else {
            fatalError("Error: No initial view controller in \(name) storyboard!")
        }
    }
    
}

extension UIViewController {
  func alert(title: String, message: String, style: UIAlertController.Style) {
    let alertController = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: style)
    
    let action = UIAlertAction(title: "OK", style: .default)
    alertController.addAction(action)
    self.present(alertController, animated: true, completion: nil)
  }
}
