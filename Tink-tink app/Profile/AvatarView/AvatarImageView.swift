//
//  AvatarImageView.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 19.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import UIKit


final class AvatarImageView: UIImageView {
  
  override func layoutSubviews() {
      super.layoutSubviews()
    self.backgroundColor = #colorLiteral(red: 0.8941176471, green: 0.9098039216, blue: 0.168627451, alpha: 1)
    self.clipsToBounds = true
    self.layer.cornerRadius = self.frame.width / 2
  }
  
  override func prepareForInterfaceBuilder() {
      setNeedsLayout()
  }
}
