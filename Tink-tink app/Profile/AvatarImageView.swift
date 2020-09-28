//
//  AvatarImageView.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 19.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import UIKit


class AvatarImageView: UIImageView {
  
  override func layoutSubviews() {
      super.layoutSubviews()
    self.clipsToBounds = true
    self.layer.cornerRadius = self.frame.width / 2
  }
  
  override func prepareForInterfaceBuilder() {
      setNeedsLayout()
  }
}
