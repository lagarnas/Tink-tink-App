//
//  NightTheme.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 05.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

class NightTheme: Themable {
  var tintColor: UIColor = .white
  var onlineIndicator: UIColor = .systemGreen
  var incomingMessageColor: UIColor = #colorLiteral(red: 0.1803921569, green: 0.1803921569, blue: 0.1803921569, alpha: 1)
  var outgoingMessageColor: UIColor = #colorLiteral(red: 0.3607843137, green: 0.3607843137, blue: 0.3607843137, alpha: 1)
  var accent: UIColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 0.6022313784)
  var backgroundAppColor: UIColor = .black
  var backgroundChatColor: UIColor = .black
  var mainTextColor: UIColor = .white
  var minorTextColor: UIColor = #colorLiteral(red: 0.5529411765, green: 0.5529411765, blue: 0.5764705882, alpha: 1)
}
