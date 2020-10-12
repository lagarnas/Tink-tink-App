//
//  ProfileVC + UIAlertController.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 12.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

extension ProfileViewController {
  
  func alert(title: String, message: String, style: UIAlertController.Style) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: style)

    let action = UIAlertAction(title: "OK", style: .default)

    alertController.addAction(action)

    self.present(alertController, animated: true, completion: nil)
  }
  
  func alertError(title: String, message: String, style: UIAlertController.Style) {

    let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
    
    let actionOK = UIAlertAction(title: "OK", style: .default)
    let actionRepeat = UIAlertAction(title: "Try again", style: .default) {_ in
      self.GCDButtonTapped()
    }
    alertController.addAction(actionOK)
    alertController.addAction(actionRepeat)

    self.present(alertController, animated: true, completion: nil)
  }
}
