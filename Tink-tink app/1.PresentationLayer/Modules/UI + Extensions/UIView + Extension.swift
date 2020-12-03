//
//  UIView + Extension.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 28.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

// MARK: Extension UIView + nibName, reuseIdentifier
extension UIView {
  
  static var nibName: String {
    return String(describing: self)
  }
  
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}
