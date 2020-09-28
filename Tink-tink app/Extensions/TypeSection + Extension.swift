//
//  TypeSection + Extension.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 28.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

extension TypeSection {
  enum Title: String {
    case online = "Online"
    case offline = "History"
  }
  
  static func group(chats: [ConversationCellModel]) -> [TypeSection] {
    let groups = Dictionary(grouping: chats) { chat -> Bool in
      chat.isOnline
    }
    
    return groups.map({ (isOnline, chats) in
      let title = isOnline ? TypeSection.Title.online.rawValue: TypeSection.Title.offline.rawValue
      return TypeSection(title: title, isOnline: isOnline, chats: chats)
    }).sorted { (online, history) -> Bool in online.isOnline }
  }
}
