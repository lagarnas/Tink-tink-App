//
//  ConversationTableViewCell.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 28.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

protocol ConfigurableView {
  associatedtype ConfigurtionModel
  func configure(model: ConfigurtionModel)
}

final class ConversationTableViewCell: UITableViewCell {
  
  @IBOutlet private weak var avatarView: MiniAvatarView!
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var previewMessageLabel: UILabel!
  @IBOutlet private weak var dateLabel: UILabel!
  @IBOutlet private weak var onlineIndicatorView: UIView!
  
  override func prepareForReuse() {
    self.backgroundColor = .clear
    avatarView.imageView.image = nil
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setupOnlineIndicator()
  }
  
  //MARK: Functions
  private func setupOnlineIndicator() {
    onlineIndicatorView.clipsToBounds = true
    onlineIndicatorView.layer.cornerRadius = onlineIndicatorView.frame.width / 2
    onlineIndicatorView.layer.borderColor = UIColor.white.cgColor
    onlineIndicatorView.layer.borderWidth = 2
  }
  
  private func setupInitialsOfName() {
    let nameAv = String(nameLabel.text?.first ?? " ")
    let secondNameAv = String(nameLabel.text?.components(separatedBy: " ")[1].first ?? " ")
    avatarView.miniNameLabel.text = nameAv
    avatarView.miniSecondNameLabel.text = secondNameAv
  }
}

//MARK: - ConfigurableView Protocol
extension ConversationTableViewCell: ConfigurableView {
  typealias ConfigurtionModel = ConversationCellModel
  
  func configure(model: ConversationCellModel) {
    
    onlineIndicatorView.isHidden = model.isOnline ? false : true
    previewMessageLabel.font = model.hasUnreadMessages && model.message != ""  ? UIFont.boldSystemFont(ofSize: 13) : UIFont.systemFont(ofSize: 13)
    
    if model.message == "" {
      previewMessageLabel.text =  "No messages yet..."
      previewMessageLabel.font = UIFont.italicSystemFont(ofSize: 13)
      dateLabel.isHidden = true
    } else {
      previewMessageLabel.text = model.message
      previewMessageLabel.font = UIFont.systemFont(ofSize: 13)
      dateLabel.isHidden = false
    }
    
    dateLabel.text = model.date.getFormattingDate()
    nameLabel.text = model.name
    
    setupInitialsOfName()
    guard let avatar = model.avatar else { return }
    avatarView.miniImageView.image = UIImage(data: avatar)
  }
}
