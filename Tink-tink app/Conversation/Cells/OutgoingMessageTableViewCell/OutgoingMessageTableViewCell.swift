//
//  OutgoingMessageTableViewCell.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 30.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

final class OutgoingMessageTableViewCell: UITableViewCell {
  
  @IBOutlet private weak var bubbleView: UIView!
  @IBOutlet private weak var messageLabel: UILabel!
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.backgroundColor = .clear
    bubbleView.backgroundColor = Theme.current.outgoingMessageColor
    messageLabel.textColor = Theme.current.mainTextColor
    bubbleView.layer.cornerRadius = 12
  }
}

//MARK: - ConfigurableView Protocol
extension OutgoingMessageTableViewCell: ConfigurableView {
  
  typealias ConfigurtionModel = MessageCellModel
  
  func configure(model: MessageCellModel) {
    self.messageLabel.text = model.text
  }
}
