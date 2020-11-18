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
  
  func saveChannels(_ channels: [Channel]) {
  
    coreDataStack.performSave { context in
      let request: NSFetchRequest<Channel_db> = Channel_db.fetchRequest()
      let savedChannels = try? coreDataStack.mainContext.fetch(request)
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
  
  func deleteChannel(_ channelObject: NSManagedObject) {
    
    coreDataStack.mainContext.delete(channelObject)
    coreDataStack.performSave(in: coreDataStack.mainContext)
  }
  
  func saveMessages(_ channel: Channel_db, _ messages: [Message]) {
    
    coreDataStack.performSave { context in

      let request: NSFetchRequest<Channel_db> = Channel_db.fetchRequest()
      guard let identifier = channel.identifier else { return }
      request.predicate = NSPredicate(format: "identifier = %@", identifier)
      let objects = try? context.fetch(request)
      guard let channel = objects?.first
      else { return }
      
      var messagesDb = [Message_db]()
      messages.forEach { message in
        
        let savedMessage = channel.messages?.filter {
          message.created == ($0 as? Message_db)?.created
        }.first
        if savedMessage == nil {
          let messageDb = Message_db(senderId: message.senderId,
                                     senderName: message.senderName,
                                     content: message.content,
                                     created: message.created,
                                     in: context)
          messagesDb.append(messageDb)
          channel.addToMessages(messageDb)
        }
      }
      print("For channel:", channel.name!, "saved:", messagesDb.count, "messages")
    }
  }
}
