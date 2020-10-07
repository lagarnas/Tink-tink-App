//
//  Themeable.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 05.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

protocol Themable {
  //navBar, buttons, actionSheet
  var accent: UIColor { get }
  var backgroundAppColor: UIColor { get }
  //backgroundChat
  var backgroundChatColor: UIColor { get }
  //main font color
  var mainTextColor: UIColor { get }
  //minor font color
  var minorTextColor: UIColor { get }
  var incomingMessageColor: UIColor { get }
  var outgoingMessageColor: UIColor { get }
}
