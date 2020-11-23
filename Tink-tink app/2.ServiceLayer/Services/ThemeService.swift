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

protocol IThemeService {
  var current: Themable { get }
  var currentMode: ThemeMode { get }
  func applyUIApplicationComponents()
  func save(themeMode: ThemeMode, completion: @escaping () -> Void)
}

final class ThemeService: IThemeService {
  
  let themeStorage: IThemeStorage
  
  init(themeStorage: IThemeStorage) {
    self.themeStorage = themeStorage
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
    let themeModeValue = themeStorage.retriveThemeModeValue()
    let themeMode = ThemeMode(rawValue: themeModeValue) ?? .classic
    return themeMode
    
  }
  
  var navBarStyle: UIBarStyle {
    switch currentMode {
    case .classic:
      return .default
    case .day:
      return .default
    case .night:
      return .black
    }
  }
  
  func applyUIApplicationComponents() {
    let sharedApplication = UIApplication.shared
    sharedApplication.delegate?.window??.tintColor = current.tintColor
    sharedApplication.delegate?.window??.backgroundColor = current.backgroundAppColor
    UINavigationBar.appearance().barStyle = navBarStyle
    UITextField.appearance().backgroundColor = .clear
    UITextField.appearance().keyboardAppearance = currentMode == .night ? .dark : .light
  }
    
  func save(themeMode: ThemeMode, completion: @escaping () -> Void) {
    themeStorage.save(themeMode: themeMode, completion: completion)
  }
}
