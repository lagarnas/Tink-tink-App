//
//  ThemeButton.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 03.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

final class ThemeButton: UIButton {
  
  private let bubble = UIView()
  private let secondBubble = UIView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupButton()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupButton()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    layer.borderWidth = isSelected ? 3 : 1
    layer.borderColor = isSelected ? #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1) : #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
  }
  
  private func setupButton() {
    layer.borderWidth = 1
    layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
    layer.cornerRadius = 20
    
    addFirstBubbleView()
    addSecondBubbleView()
    setupConstraints()
  }
  
  
  
  private func addFirstBubbleView() {
    switch self.tag {
    case 0:
      bubble.backgroundColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
    case 1:
      bubble.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.9215686275, blue: 0.9294117647, alpha: 1)
    case 2:
      bubble.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.1803921569, blue: 0.1803921569, alpha: 1)
    default:
      bubble.backgroundColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
    }
    bubble.isUserInteractionEnabled = false
    bubble.layer.cornerRadius = 10
    bubble.layer.zPosition = -1
    self.addSubview(bubble)
  }
  
  private func addSecondBubbleView() {
    switch self.tag {
    case 0:
      secondBubble.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.968627451, blue: 0.7725490196, alpha: 1)
    case 1:
      secondBubble.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.537254902, blue: 0.9764705882, alpha: 1)
    case 2:
      secondBubble.backgroundColor = #colorLiteral(red: 0.3607843137, green: 0.3607843137, blue: 0.3607843137, alpha: 1)
    default:
      bubble.backgroundColor = #colorLiteral(red: 0.3607843137, green: 0.3607843137, blue: 0.3607843137, alpha: 1)
    }
    secondBubble.isUserInteractionEnabled = false
    
    secondBubble.layer.cornerRadius = 10
    secondBubble.layer.zPosition = -1
    self.addSubview(secondBubble)
  }
  
  private func setupConstraints() {
    bubble.translatesAutoresizingMaskIntoConstraints = false
    secondBubble.translatesAutoresizingMaskIntoConstraints = false
    
    let views = [
      "bubble": bubble,
      "secondBubble": secondBubble
    ]
    
    var constraints = [NSLayoutConstraint]()
    let vBubbleConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[bubble]-22-|", options: .init(rawValue: 0), metrics: nil, views: views)
    constraints += vBubbleConstraint
    let vSecondBubbleConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-22-[secondBubble]-10-|", options: .init(rawValue: 0), metrics: nil, views: views)
    constraints += vSecondBubbleConstraint
    let hBubbleConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[bubble]-[secondBubble(==bubble)]-20-|", options: .init(rawValue: 0), metrics: nil, views: views)
    constraints += hBubbleConstraint
    NSLayoutConstraint.activate(constraints)
  }
  
  func shake() {
    let shake          = CABasicAnimation(keyPath: "position")
    shake.duration     = 0.1
    shake.repeatCount  = 2
    shake.autoreverses = true
    
    let fromPoint      = CGPoint(x: center.x - 8, y: center.y)
    let fromValue      = NSValue(cgPoint: fromPoint)
    
    let toPoint        = CGPoint(x: center.x + 8, y: center.y)
    let toValue        = NSValue(cgPoint: toPoint)
    
    shake.fromValue    = fromValue
    shake.toValue      = toValue
    
    layer.add(shake, forKey: "position")
    
    
  }
  
  
}
