//
//  UIAlertController + constraints.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 19.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

extension UIAlertController {
  func pruneNegativeWidthConstraints() {
    for subView in self.view.subviews {
      for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
        subView.removeConstraint(constraint)
      }
    }
  }
}

extension UIAlertAction {

    var titleTextColor: UIColor? {
        get {
            return self.value(forKey: "titleTextColor") as? UIColor
        } set {
            self.setValue(newValue, forKey: "titleTextColor")
        }
    }
}
