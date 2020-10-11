//
//  ProfileVC + updateTheme.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 10.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

extension ProfileViewController {
  func updateTheme() {
    ThemeManager.shared.applyTheme()
    view.backgroundColor = ThemeManager.shared.current.backgroundAppColor
    nameLabel.textColor = ThemeManager.shared.current.mainTextColor
    bioLabel.textColor = ThemeManager.shared.current.mainTextColor
    operationButton.backgroundColor = ThemeManager.shared.current.accent
    operationButton.setTitleColor(ThemeManager.shared.current.tintColor, for: .normal)
    GCDButton.backgroundColor = ThemeManager.shared.current.accent
    GCDButton.setTitleColor(ThemeManager.shared.current.tintColor, for: .normal)
  }
}
