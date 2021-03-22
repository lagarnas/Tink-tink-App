//
//  ProfileVC + UIAlert.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 11.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

extension ProfileViewController {
  // MARK: Public Methods
  func alertError(title: String, message: String, style: UIAlertController.Style) {
    let alertController = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: style)
    
    let actionOK = UIAlertAction(title: "OK", style: .default) {_ in
      self.activityIndicator.stopAnimating()
    }
    let actionRepeat = UIAlertAction(title: "Try again", style: .default) {_ in
      if self.GCDButtonIsClick {
        self.GCDButtonTapped()
      } else {
        self.operationButtonTapped(self.operationButton)
      }
    }
    alertController.addAction(actionOK)
    alertController.addAction(actionRepeat)
    self.present(alertController, animated: true, completion: nil)
  }
}
