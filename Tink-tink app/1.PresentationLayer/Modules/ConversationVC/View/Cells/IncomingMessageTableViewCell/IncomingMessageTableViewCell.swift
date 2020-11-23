//
//  MessageTableViewCell.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 29.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

final class IncomingMessageTableViewCell: UITableViewCell {
  
  @IBOutlet private weak var bubbleView: UIView!
  @IBOutlet private weak var messageLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  
  var themeModel: IThemeModel?
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.backgroundColor = .clear
    bubbleView.backgroundColor = themeModel?.current.incomingMessageColor
    messageLabel.textColor = themeModel?.current.mainTextColor
    bubbleView.layer.cornerRadius = 12
  }
}

// MARK: - ConfigurableView Protocol
extension IncomingMessageTableViewCell: ConfigurableView {
  
  typealias ConfigurtionModel = Message_db
  
  func configure(model: Message_db) {
    self.nameLabel.text = model.senderName
    self.messageLabel.text = model.content
  }
  
}
