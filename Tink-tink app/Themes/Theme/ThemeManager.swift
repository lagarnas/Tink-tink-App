//
//  Theme.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 05.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

class ThemeManager {
  
  static let shared = ThemeManager()
  private init() {}
  
  func applyTheme() {
    // 1
    UserDefaults.standard.synchronize()
    // 2
    let sharedApplication = UIApplication.shared
    sharedApplication.delegate?.window??.tintColor = current.tintColor
    sharedApplication.delegate?.window??.backgroundColor = current.backgroundAppColor
    UINavigationBar.appearance().barStyle = barStyle
    UITextField.appearance().backgroundColor = current.accent
    if currentMode == .night {
      UITextField.appearance().keyboardAppearance = UIKeyboardAppearance.dark
    } else {
      UITextField.appearance().keyboardAppearance = UIKeyboardAppearance.light
    }
  }
  
  var current: Themable {
    switch currentMode {
    case .classic:
      return ClassicTheme()
    case .day:
      return DayTheme()
    case .night:
      return NightTheme()
    }
  }
  
  var currentMode: ThemeMode {
    let themeModeValue = UserDefaults.standard.integer(forKey: "themeMode")
    let themeMode = ThemeMode(rawValue: themeModeValue) ?? .classic
    return themeMode
  }
  
  func saveStates(themeMode: ThemeMode) {
    UserDefaults.standard.set(themeMode.rawValue, forKey: "themeMode")
  }
  
}


extension ThemeManager {
  var barStyle: UIBarStyle {
    switch currentMode {
    case .classic:
      return .default
    case .day:
      return .default
    case .night:
      return .black
    }
  }
}
