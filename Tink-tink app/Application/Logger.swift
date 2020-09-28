//
//  Log.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 24.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import os.log

extension OSLog {
  private static var subsystem = Bundle.main.bundleIdentifier!
  
  //Logs the app cycles
  static var appCycle = OSLog(subsystem: subsystem, category: "appcycle")
  // Logs the view cycles like viewDidLoad.
  static let viewCycle = OSLog(subsystem: subsystem, category: "viewcycle")
  // Logs the view frame is changing
  static let frameChanged = OSLog(subsystem: subsystem, category: "frameChanged")
}


@available(iOS 14.0, *)
extension Logger {
  private static var subsystem = Bundle.main.bundleIdentifier!
  //Logs the app cycles
  static var appCycle = Logger(subsystem: subsystem, category: "appcycle")
  //Logs the view cycles like viewDidLoad.
  static let viewCycle = Logger(subsystem: subsystem, category: "viewcycle")
  // Logs the view frame is changing
  static let frameChanged = Logger(subsystem: subsystem, category: "frameChanged")
}



