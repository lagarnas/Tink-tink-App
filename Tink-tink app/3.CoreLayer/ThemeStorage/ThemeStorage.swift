//
//  ThemeStorage.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 11.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

enum FileName: String {
   case userName  = "userName.txt"
   case userBio   = "userBio.txt"
   case userPhoto = "photo.png"
   case userTheme = "theme.txt"
 }

protocol IThemeStorage {
  func retriveThemeModeValue() -> Int
  func save(themeMode: ThemeMode, completion: @escaping () -> Void)
}

class ThemeStorage: IThemeStorage {
  
  let fileManager = FileManager.default
  let queue = DispatchQueue(label: "Theme", qos: .background, attributes: .concurrent)
  
  func retriveThemeModeValue() -> Int {
    var themeModeValueString = ""
    do {
      if self.fileManager.fileExists(atPath: self.fileURL(.userTheme).path) {
        themeModeValueString = try String(contentsOf: self.fileURL(.userTheme))
      }
    } catch {
      print(error.localizedDescription)
    }
    return Int(themeModeValueString) ?? 0
  }
  
  func save(themeMode: ThemeMode, completion: @escaping () -> Void) {
    queue.async {
      let themeMode = String(themeMode.rawValue)
      
      do {
        let themeURL = self.fileURL(.userTheme)
        try themeMode.write(to: themeURL, atomically: true, encoding: .utf8)
        DispatchQueue.main.async {
          print("Theme mode saved:", themeMode)
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
