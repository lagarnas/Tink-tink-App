//
//  ConversationVC + data.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 10.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

//MARK: - UITextFieldDelegate
extension ConversationViewController: UITextFieldDelegate {
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    self.view.layoutIfNeeded()
    UIView.animate(withDuration: 0.5, animations: {
      self.dockViewHeightConstraint.constant = 80
      self.view.layoutIfNeeded()
    }, completion: nil)
  }
}

