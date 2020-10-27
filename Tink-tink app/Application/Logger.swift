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
  // Logs the deinit is performing
  static let retainCycle = OSLog(subsystem: subsystem, category: "retainCycle")
  // Core data logs
  static let coreData = OSLog(subsystem: subsystem, category: "coreData")
}
