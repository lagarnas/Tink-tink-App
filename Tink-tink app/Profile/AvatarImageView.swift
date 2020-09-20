//
//  AvatarImageView.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 19.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class AvatarImageView: UIImageView {
  
  private var size = CGSize()
  @IBInspectable var cornerRadiiSize: CGFloat = 0 {
      didSet {
          size = CGSize(width: cornerRadiiSize, height: cornerRadiiSize)
      }
  }
  
  override func layoutSubviews() {
      super.layoutSubviews()
      let shapeLayer = CAShapeLayer()
    shapeLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .bottomRight, .topRight, .bottomLeft], cornerRadii: size).cgPath
      
      layer.mask = shapeLayer
  }
  
  override func prepareForInterfaceBuilder() {
      setNeedsLayout()
  }
}
