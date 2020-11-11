//
//  ConversationListVC + UIAlertController.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 20.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

extension ConversationsListViewController {
  
  func showChannelAlert() {
    let alertController = UIAlertController(title: "New channel", message: nil, preferredStyle: .alert)
    
    let createAction = UIAlertAction(title: "Create", style: .default) {_ in
      let text = alertController.textFields?.first?.text
      guard let channelName = text else { return }
      FirebaseManager.shared.insertChannel(name: channelName)
      
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    alertController.addTextField { (textField) in
      textField.placeholder = "Add new channel"
    }
    alertController.addAction(createAction)
    alertController.addAction(cancelAction)
    
    self.present(alertController, animated: true, completion: nil)
  }
}
