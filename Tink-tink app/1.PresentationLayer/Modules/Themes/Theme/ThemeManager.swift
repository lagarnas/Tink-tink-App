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
  
  let fileManager = FileManager.default
  let queue = DispatchQueue(label: "Theme", qos: .background, attributes: .concurrent)
  
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
    //    let themeModeValue = UserDefaults.standard.integer(forKey: "themeMode")
    //    let themeMode = ThemeMode(rawValue: themeModeValue) ?? .classic
    //    return themeMode
    
    var themeModeValueString = ""
    do {
      if self.fileManager.fileExists(atPath: self.fileURL(.userTheme).path) {
        themeModeValueString = try String(contentsOf: self.fileURL(.userTheme))
      }
    } catch {
      print(error.localizedDescription)
    }

    let themeModeValue = Int(themeModeValueString)

    let themeMode = ThemeMode(rawValue: themeModeValue ?? 0) ?? .classic
    return themeMode
    
  }
  
  func save(themeMode: ThemeMode, completion: @escaping () -> Void) {
    //UserDefaults.standard.set(themeMode.rawValue, forKey: "themeMode")
    
    queue.async {
      let themeMode = String(themeMode.rawValue)
      
      do {
        let themeURL = self.fileURL(.userTheme)
        try themeMode.write(to: themeURL, atomically: true, encoding: .utf8)
        DispatchQueue.main.async {
          completion()
        }
      } catch {
        print(error.localizedDescription)
      }
    }

  }
  
  private func fileURL(_ fileName: FileName) -> URL {
    var documentDirURL = URL(string: "")
    do {
      documentDirURL = try fileManager.url(for: .documentDirectory,
                                                in: .userDomainMask,
                                                appropriateFor: nil,
                                                create: true)
    } catch  { print(error.localizedDescription) }
    let fileURL = documentDirURL!.appendingPathComponent(fileName.rawValue)
    return fileURL
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
