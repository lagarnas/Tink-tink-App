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
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.backgroundColor = .clear
    bubbleView.backgroundColor = ThemeManager.shared.current.incomingMessageColor
    messageLabel.textColor = ThemeManager.shared.current.mainTextColor
    bubbleView.layer.cornerRadius = 12
  }
}

// MARK: - ConfigurableView Protocol
extension IncomingMessageTableViewCell: ConfigurableView {
  
  typealias ConfigurtionModel = Message
  
  func configure(model: Message) {
    self.messageLabel.text = model.content
  }
  
}
