//
//  ConversationVC + UpdateTheme.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 10.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

extension ConversationViewController {
  func updateTheme() {
    ThemeManager.shared.applyTheme()
    
    self.tableView.backgroundColor = ThemeManager.shared.current.backgroundChatColor
    self.navigationController?.navigationBar.backgroundColor = ThemeManager.shared.current.backgroundAppColor
    self.dockView.backgroundColor = ThemeManager.shared.current.backgroundAppColor
    self.messageTextField.backgroundColor = ThemeManager.shared.current.incomingMessageColor
    self.messageTextField.textColor = ThemeManager.shared.current.mainTextColor
  }
}
