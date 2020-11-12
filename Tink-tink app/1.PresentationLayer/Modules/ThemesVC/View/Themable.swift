//
//  Themeable.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 05.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

protocol Themable {
  var accent: UIColor { get }
  var tintColor: UIColor { get }
  var onlineIndicator: UIColor { get }
  var backgroundAppColor: UIColor { get }
  var backgroundChatColor: UIColor { get }
  var mainTextColor: UIColor { get }
  var minorTextColor: UIColor { get }
  var incomingMessageColor: UIColor { get }
  var outgoingMessageColor: UIColor { get }
}

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

struct DayTheme: Themable {
  var onlineIndicator: UIColor = #colorLiteral(red: 0.262745098, green: 0.537254902, blue: 0.9764705882, alpha: 1)
  var tintColor: UIColor = .systemBlue
  var incomingMessageColor: UIColor = #colorLiteral(red: 0.9176470588, green: 0.9215686275, blue: 0.9294117647, alpha: 1)
  var outgoingMessageColor: UIColor = #colorLiteral(red: 0.262745098, green: 0.537254902, blue: 0.9764705882, alpha: 1)
  var accent: UIColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
  var backgroundAppColor: UIColor = .white
  var backgroundChatColor: UIColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
  var mainTextColor: UIColor = .black
  var minorTextColor: UIColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.601375214)
}

struct NightTheme: Themable {
  var tintColor: UIColor = .white
  var onlineIndicator: UIColor = .systemGreen
  var incomingMessageColor: UIColor = #colorLiteral(red: 0.1803921569, green: 0.1803921569, blue: 0.1803921569, alpha: 1)
  var outgoingMessageColor: UIColor = #colorLiteral(red: 0.3607843137, green: 0.3607843137, blue: 0.3607843137, alpha: 1)
  var accent: UIColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 0.6022313784)
  var backgroundAppColor: UIColor = .black
  var backgroundChatColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
  var mainTextColor: UIColor = .white
  var minorTextColor: UIColor = #colorLiteral(red: 0.5529411765, green: 0.5529411765, blue: 0.5764705882, alpha: 1)
}
