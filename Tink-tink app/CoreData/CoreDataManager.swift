//
//  CoreDataManager.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 23.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
  
  static let shared = CoreDataManager()
  private init() {}
  
  let coreDataStack = CoreDataStack.shared
  
  func makeSaveChannelsRequest(channels: [Channel]) {
    
    let request: NSFetchRequest<Channel_db> = Channel_db.fetchRequest()
    let savedChannels = try? coreDataStack.mainContext.fetch(request)
    
    coreDataStack.performSave { context in
      channels.forEach { channel in
        
        let savedChannel = savedChannels?.filter {
          $0.identifier == channel.identifier
        }.first
        
        if savedChannel == nil {
          Channel_db(identifier: channel.identifier,
                                     name: channel.name,
                                     lastActivity: channel.lastActivity,
                                     lastMessage: channel.lastMessage,
                                     in: context)
        } else {
          savedChannel?.name = channel.name
          savedChannel?.lastActivity = channel.lastActivity
          savedChannel?.lastMessage = channel.lastMessage
        }
      }
    }
  }
  
  func makeSaveMessagesRequest(channel: Channel, messages: [Message]) {
    
    coreDataStack.performSave { context in

      let request: NSFetchRequest<Channel_db> = Channel_db.fetchRequest()
      request.predicate = NSPredicate(format: "identifier = %@", channel.identifier)
      let objects = try? context.fetch(request)
      guard let channel = objects?.first
      else { return }
      
      var messagesDb = [Message_db]()
      messages.forEach {
        let messageDb = Message_db(senderId: $0.senderId,
                                   senderName: $0.senderName,
                                   content: $0.content,
                                   created: $0.created,
                                   in: context)
        messagesDb.append(messageDb)
        channel.addToMessages(messageDb)
      
      }
      print("For channel:", channel.name!, "saved:", messagesDb.count, "messages")
    }
  }
}
