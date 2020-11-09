//
//  ObjectsExtensions.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 23.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import CoreData

extension Channel_db {
  convenience init(identifier: String,
                   name: String,
                   lastActivity: Date?,
                   lastMessage: String?,
                   in context: NSManagedObjectContext){
    self.init(context: context)
    self.identifier = identifier
    self.name = name
    self.lastActivity = lastActivity
    self.lastMessage = lastMessage
  }
}

extension Message_db {
  convenience init(senderId: String,
                   senderName: String,
                   content: String,
                   created: Date,
                   in context: NSManagedObjectContext) {
    self.init(context: context)
    self.senderId = senderId
    self.senderName = senderName
    self.content = content
    self.created = created
  }
}
