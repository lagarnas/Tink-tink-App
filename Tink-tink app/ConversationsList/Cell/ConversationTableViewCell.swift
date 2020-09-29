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

class ConversationTableViewCell: UITableViewCell {
  @IBOutlet weak var avatarView: UIView!
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var previewMessageLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var onlineIndicatorView: UIView!
  
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  override func prepareForReuse() {
    self.backgroundColor = .clear
    avatarImageView.image = nil
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    avatarImageView.clipsToBounds = true
    avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
    onlineIndicatorView.clipsToBounds = true
    onlineIndicatorView.layer.cornerRadius = onlineIndicatorView.frame.width / 2
    onlineIndicatorView.layer.borderColor = UIColor.white.cgColor
    onlineIndicatorView.layer.borderWidth = 2
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}

extension ConversationTableViewCell: ConfigurableView {
  typealias ConfigurtionModel = ConversationCellModel
  
  func configure(model: ConversationCellModel) {
    
    onlineIndicatorView.isHidden = model.isOnline ? false : true
    self.avatarView.backgroundColor = model.isOnline ? #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1) : .white
    previewMessageLabel.font = model.hasUnreadMessages && model.message != "" ? UIFont.boldSystemFont(ofSize: 13) : UIFont.systemFont(ofSize: 13)
    previewMessageLabel.text = model.message == "" ? "No messages yet..." : model.message
    previewMessageLabel.font = model.message == "" ? UIFont.italicSystemFont(ofSize: 13) : UIFont.systemFont(ofSize: 13)
    self.backgroundColor = model.isOnline ? #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1) : .white
    
    
//    let formatter = DateFormatter()
//    formatter.dateFormat = "HH:mm"
    //здесь будет функция которая форматирует дату в строку в зависомости от того какая дата пришла (сегодня, вчера и тд)
    dateLabel.text = model.date.getFormattingDate()
    nameLabel.text = model.name
    
    guard let avatar = model.avatar else {
      avatarImageView.image = #imageLiteral(resourceName: "2020-01-23 14.33.44")
      return
    }
    avatarImageView.image = UIImage(data: avatar)
    
    
  }
  
  
  
  
  
}
