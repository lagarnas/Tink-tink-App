//
//  ConversationCellModel.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 28.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

struct ConversationCellModel {
  let avatar: Data?
  let name: String
  let message: String
  let date: Date
  let isOnline: Bool
  let hasUnreadMessages: Bool
}
