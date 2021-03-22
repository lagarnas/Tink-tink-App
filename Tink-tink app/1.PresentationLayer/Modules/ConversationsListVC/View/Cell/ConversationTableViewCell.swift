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
  // MARK: IBOutlets
  @IBOutlet private weak var avatarView: MiniAvatarView!
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var previewMessageLabel: UILabel!
  @IBOutlet private weak var dateLabel: UILabel!
  @IBOutlet private weak var onlineIndicatorView: UIView!
  @IBOutlet weak var forwardIcon: UIImageView!
  // MARK: Public properties
  var themeModel: IThemeModel?
  
  // MARK: Lifecycle
  override func prepareForReuse() {
    super.prepareForReuse()
    self.backgroundColor = .clear
    avatarView.imageView.image = nil
    avatarView.miniNameLabel.text = nil
    avatarView.miniSecondNameLabel.text = nil
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setupOnlineIndicator()
    updateTheme()
  }
  // MARK: Private Methods
  private func updateTheme() {
    nameLabel.textColor = themeModel?.current.mainTextColor
    previewMessageLabel.textColor = themeModel?.current.minorTextColor
    dateLabel.textColor = themeModel?.current.minorTextColor
    forwardIcon.tintColor = themeModel?.current.tintColor
    onlineIndicatorView.backgroundColor = themeModel?.current.onlineIndicator
  }
  
  private func setupOnlineIndicator() {
    onlineIndicatorView.clipsToBounds = true
    onlineIndicatorView.layer.cornerRadius = onlineIndicatorView.frame.width / 2
    onlineIndicatorView.layer.borderColor = UIColor.white.cgColor
    onlineIndicatorView.layer.borderWidth = 2
  }
  
  private func setupInitialsOfName() {
    let nameAv = String(nameLabel.text?.first ?? " ")
    if nameLabel.text?.components(separatedBy: " ").count ?? 0 > 1 {
      let secondNameAv = String(nameLabel.text?.components(separatedBy: " ")[1].first ?? " ")
       avatarView.miniSecondNameLabel.text = secondNameAv
    }
    
    avatarView.miniNameLabel.text = nameAv
   
  }
}

// MARK: - ConfigurableView Protocol
extension ConversationTableViewCell: ConfigurableView {
  typealias ConfigurtionModel = Channel_db
  // MARK: Public Methods
  func configure(model: Channel_db) {
    previewMessageLabel.text = model.lastMessage
    previewMessageLabel.font = model.lastMessage == "" ? UIFont.italicSystemFont(ofSize: 13) : UIFont.systemFont(ofSize: 13)
    dateLabel.text = model.lastActivity?.getFormattingDate()
    nameLabel.text = model.name
    
    setupInitialsOfName()
  }
}
