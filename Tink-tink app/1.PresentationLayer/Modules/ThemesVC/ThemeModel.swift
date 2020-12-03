//
//  ClassicTheme.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 05.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

// MARK: IThemeModel protocol
protocol IThemeModel {
  var current: Themable { get }
  var currentMode: ThemeMode { get }
  func applyTheme()
  func save(themeMode: ThemeMode, completion: @escaping () -> Void)
}

class ThemeModel: IThemeModel {
  // MARK: Public properties
  var current: Themable
  var currentMode: ThemeMode
  let themeService: IThemeService
  
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
  
  // MARK: Initializers
  init(themeService: IThemeService) {
    self.themeService = themeService
    self.current = themeService.current
    self.currentMode = themeService.currentMode
  }
  
  // MARK: Public Methods
  func applyTheme() {
    themeService.applyUIApplicationComponents()
    self.current = themeService.current
  }
  
  func save(themeMode: ThemeMode, completion: @escaping () -> Void) {
    themeService.save(themeMode:  themeMode, completion: completion)
  }
}
