//
//  MiniAvatarView.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 30.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

class MiniAvatarView: AvatarView {
  // MARK: Public properties
  var miniNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14.0)
    label.textColor = #colorLiteral(red: 0.1725490196, green: 0.1764705882, blue: 0.1803921569, alpha: 1)
    return label
  }()
  
   var miniSecondNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14.0)
    label.textColor = #colorLiteral(red: 0.1725490196, green: 0.1764705882, blue: 0.1803921569, alpha: 1)
    return label
  }()
  
  let miniImageView: AvatarImageView = {
    let imageView = AvatarImageView()
    imageView.backgroundColor = #colorLiteral(red: 0.8941176471, green: 0.9098039216, blue: 0.168627451, alpha: 1)
    return imageView
  }()
  
  // MARK: Lifecycle
  override func layoutSubviews() {
    isAccessibilityElement = true
    addSubview(miniImageView)
    addSubview(miniNameLabel)
    addSubview(miniSecondNameLabel)
    setupConstraints()
  }
  
  // MARK: Override methods
  override func hideInitials() {
    miniNameLabel.isHidden = true
    miniSecondNameLabel.isHidden = true
  }
  
  override func setupConstraints() {
    
    miniImageView.translatesAutoresizingMaskIntoConstraints = false
    miniNameLabel.translatesAutoresizingMaskIntoConstraints = false
    miniSecondNameLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let imageViewConstrains = [
      miniImageView.topAnchor.constraint(equalTo: topAnchor),
      miniImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      miniImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      miniImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ]
    
    let nameLabelConstraints = [
      miniNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      miniNameLabel.trailingAnchor.constraint(equalTo: centerXAnchor),
      miniSecondNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      miniSecondNameLabel.leadingAnchor.constraint(equalTo: centerXAnchor)
    ]
  
    NSLayoutConstraint.activate(imageViewConstrains)
    NSLayoutConstraint.activate(nameLabelConstraints)
  }
  
}
