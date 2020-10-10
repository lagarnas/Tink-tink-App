//
//  Theme.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 05.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

enum ThemeMode: Int {
  case classic, day, night
}

final class ThemeManager {
  
  static let shared = ThemeManager()
  private init() {}
  
  func applyTheme() {
    UserDefaults.standard.synchronize()
    let sharedApplication = UIApplication.shared
    sharedApplication.delegate?.window??.tintColor = current.tintColor
    sharedApplication.delegate?.window??.backgroundColor = current.backgroundAppColor
    UINavigationBar.appearance().barStyle = barStyle
    UITextField.appearance().backgroundColor = .clear
    UITextField.appearance().keyboardAppearance = currentMode == .night ? .dark : .light
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
  
  func save(themeMode: ThemeMode) {
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
