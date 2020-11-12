//
//  ConversationsListVC + updateUI.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 11.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

extension ConversationsListViewController {
  
  func showChannelAlert() {
    let alertController = UIAlertController(title: "New channel", message: nil, preferredStyle: .alert)
    
    let createAction = UIAlertAction(title: "Create", style: .default) {_ in
      let text = alertController.textFields?.first?.text
      guard let channelName = text, let model = self.model else { return }
      model.insertChannel(name: channelName)
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    alertController.addTextField { (textField) in
      textField.placeholder = "Add new channel"
    }
    alertController.addAction(createAction)
    alertController.addAction(cancelAction)
    
    self.present(alertController, animated: true, completion: nil)
  }
  
  func updateTheme() {
    guard let themeModel = self.themeModel else { return }
    themeModel.applyTheme()
    self.view.backgroundColor = themeModel.current.backgroundAppColor
    self.tableView.backgroundColor = themeModel.current.backgroundAppColor
    self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: themeModel.current.mainTextColor]
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: themeModel.current.mainTextColor]
    settingsIcon.tintColor = themeModel.current.tintColor
  }
  
  func setupInitialsOfName(profile: Profile) {
    
    let fullNameArr = profile.userName.components(separatedBy: " ")
    let firstName: String = fullNameArr[0]
    let lastName: String? = fullNameArr.count > 1 ? fullNameArr[1] : nil
    
    let firstInitial = String(firstName.first ?? " ")
    let secondInitial = String(lastName?.first ?? " ")
    
    avatarView.miniNameLabel.text = firstInitial
    avatarView.miniSecondNameLabel.text = secondInitial
    avatarView.miniImageView.image = UIImage(data: profile.userData)
    
    if avatarView.miniImageView.image != nil {
      avatarView.hideInitials()
    }
  }
}
