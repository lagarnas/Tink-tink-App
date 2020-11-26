//
//  Conversation + UI updates.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 12.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

extension ConversationViewController: UITextFieldDelegate {
  
  func updateTheme() {
    guard let themeModel = self.themeModel else { return }
    themeModel.applyTheme()
    self.tableView.backgroundColor = themeModel.current.backgroundChatColor
    self.navigationController?.navigationBar.backgroundColor = themeModel.current.backgroundAppColor
    self.dockView.backgroundColor = themeModel.current.backgroundAppColor
    self.messageTextField.backgroundColor = themeModel.current.incomingMessageColor
    self.messageTextField.textColor = themeModel.current.mainTextColor
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    emblemView.stopAnimation()
    self.view.layoutIfNeeded()
    UIView.animate(withDuration: 0.5, animations: {
      self.dockViewHeightConstraint.constant = 80
      self.view.layoutIfNeeded()
    }, completion: nil)
  }
}
