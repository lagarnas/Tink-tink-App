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


  
  
