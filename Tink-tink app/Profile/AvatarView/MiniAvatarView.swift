//
//  AvatarView.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 30.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

class AvatarView: UIView {
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 5.0)
    label.textColor = #colorLiteral(red: 0.1725490196, green: 0.1764705882, blue: 0.1803921569, alpha: 1)
    return label
  }()
  
  let secondNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 5.0)
    label.textColor = #colorLiteral(red: 0.1725490196, green: 0.1764705882, blue: 0.1803921569, alpha: 1)
    return label
  }()
  
  let imageView: AvatarImageView = {
    let imageView = AvatarImageView()
    imageView.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
    return imageView
  }()
  
  override func layoutSubviews() {
    addSubview(imageView)
    addSubview(nameLabel)
    addSubview(secondNameLabel)
    backgroundColor = .clear
    setupConstraints()
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
      nameLabel.leadingAnchor.constraint(lessThanOrEqualTo: leadingAnchor, constant: 44),
      nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      nameLabel.trailingAnchor.constraint(equalTo: secondNameLabel.leadingAnchor, constant: 22),
      secondNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant:  -44),
      secondNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      secondNameLabel.leadingAnchor.constraint(equalTo: centerXAnchor)
      
    ]
  
    NSLayoutConstraint.activate(imageViewConstrains)
    NSLayoutConstraint.activate(nameLabelConstraints)
    
  }
  
  
}
