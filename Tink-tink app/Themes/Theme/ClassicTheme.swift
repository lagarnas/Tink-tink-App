//
//  ClassicTheme.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 05.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

struct ClassicTheme: Themable {
  var onlineIndicator: UIColor = .systemGreen
  var tintColor: UIColor = .black
  var incomingMessageColor: UIColor = .white
  var outgoingMessageColor: UIColor = #colorLiteral(red: 0.862745098, green: 0.968627451, blue: 0.7725490196, alpha: 1)
  var accent: UIColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
  var backgroundAppColor: UIColor = .white
  var backgroundChatColor: UIColor = #colorLiteral(red: 0.6640728712, green: 0.718401134, blue: 0.8778713346, alpha: 0.300968536)
  var mainTextColor: UIColor = .black
  var minorTextColor: UIColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.601375214)
}
