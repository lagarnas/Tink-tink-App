//
//  ProfileVC + updateUI.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 11.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
extension ProfileViewController {
  // MARK: Public Methods
  func configUI() {
    activityIndicator.stopAnimating()
    activityIndicator.hidesWhenStopped = true
    operationButton.clipsToBounds = true
    operationButton.layer.cornerRadius = 10
    GCDButton.clipsToBounds = true
    GCDButton.layer.cornerRadius = 10
    GCDButton.addTarget(self, action: #selector(GCDButtonTapped), for: .touchUpInside)
  }
  
  func updateUI() {
    activityIndicator.stopAnimating()
    alert(title: "Data saved", message: "", style: .alert)
    setupInitialsOfName()
    unEnabledUIElements()
    editButton.isEnabled = true
  }
  
  func enabledUIElements() {
    setImageButton.isHidden = false
    nameTextField.isEnabled = true
    bioTextView.isEditable = true
  }
  
  func unEnabledUIElements() {
    setImageButton.isHidden = true
    nameTextField.isEnabled = false
    bioTextView.isEditable = false
    unEnabledButtons()
  }
  
  func enabledButtons() {
    self.GCDButton.isEnabled = true
    self.operationButton.isEnabled = true
  }
  
  func unEnabledButtons() {
    GCDButton.isEnabled = false
    operationButton.isEnabled = false
  }
  
  func hideInitials() {
    avatarView.nameLabel.isHidden = true
    avatarView.secondNameLabel.isHidden = true
  }
  
  func setupInitialsOfName() {
    if avatarView.imageView.image != nil {
      avatarView.hideInitials()
    } else {
      guard let tf = nameTextField.text else { return }
      let fullName = tf
      let fullNameArr = fullName.components(separatedBy: " ")
      let firstName: String = fullNameArr[0]
      let lastName: String? = fullNameArr.count > 1 ? fullNameArr[1] : nil
      
      let firstInitial = String(firstName.first ?? " ")
      let secondInitial = String(lastName?.first ?? " ")
      
      avatarView.nameLabel.text = firstInitial
      avatarView.secondNameLabel.text = secondInitial
    }
  }
  
  func updateTheme() {
    guard let themeModel = self.themeModel else { return }
    themeModel.applyTheme()
    view.backgroundColor = themeModel.current.backgroundAppColor
    scrollView.backgroundColor = themeModel.current.backgroundAppColor
    contentView.backgroundColor = themeModel.current.backgroundAppColor
    
    nameLabel.textColor = themeModel.current.mainTextColor
    nameTextField.textColor = themeModel.current.mainTextColor
    nameSeparator.backgroundColor = themeModel.current.accent
    
    bioLabel.textColor = themeModel.current.mainTextColor
    bioTextView.backgroundColor = themeModel.current.backgroundAppColor
    bioTextView.textColor = themeModel.current.mainTextColor
    bioSeparator.backgroundColor = themeModel.current.accent
    
    operationButton.backgroundColor = themeModel.current.accent
    operationButton.setTitleColor(themeModel.current.tintColor, for: .normal)
    
    GCDButton.backgroundColor = themeModel.current.accent
    GCDButton.setTitleColor(themeModel.current.tintColor, for: .normal)
  }
}
