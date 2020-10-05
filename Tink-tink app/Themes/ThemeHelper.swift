//
//  Theme.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 05.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

class ThemeHelper {
  static let shared = ThemeHelper()
  private init() {}
  
  func setupCurrentTheme(_ theme: Themeable) {
    Theme.current = theme
  }
}
