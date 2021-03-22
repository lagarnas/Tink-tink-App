//
//  AvatarView.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 30.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

class AvatarView: UIView {
  
  // MARK: Public properties
  let nameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 100.0)
    label.textColor = #colorLiteral(red: 0.1725490196, green: 0.1764705882, blue: 0.1803921569, alpha: 1)
    return label
  }()
  
  let secondNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 100.0)
    label.textColor = #colorLiteral(red: 0.1725490196, green: 0.1764705882, blue: 0.1803921569, alpha: 1)
    return label
  }()
  
  let imageView: AvatarImageView = {
    let imageView = AvatarImageView()
    return imageView
  }()
  
  // MARK: Lifecycle
  override func layoutSubviews() {
    addSubview(imageView)
    addSubview(nameLabel)
    addSubview(secondNameLabel)
    backgroundColor = .clear
    setupConstraints()
  }
  
  // MARK: Public Methods
  func hideInitials() {
    nameLabel.isHidden = true
    secondNameLabel.isHidden = true
  }
  
  func setupConstraints() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    secondNameLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let imageViewConstrains = [
      imageView.topAnchor.constraint(equalTo: topAnchor),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ]
    
    let nameLabelConstraints = [
      nameLabel.trailingAnchor.constraint(equalTo: centerXAnchor),
      nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      secondNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      secondNameLabel.leadingAnchor.constraint(equalTo: centerXAnchor)
    ]
  
    NSLayoutConstraint.activate(imageViewConstrains)
    NSLayoutConstraint.activate(nameLabelConstraints)
    
  }
  
}
