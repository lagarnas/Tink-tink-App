//
//  MessageCellModel.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 29.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import CoreData

struct MessageCellDisplay: Hashable {
    let senderId: String
    var senderName: String
    var content: String
    var created: Date
}

protocol IConversationModel {
  func fetchedResultController(channel: Channel_db) -> NSFetchedResultsController<Message_db>
  func insertMessage(channelId: String, message: String)
  func getMessages(channel: Channel_db)
  func senderId() -> String?
}

class ConversationModel: IConversationModel {

  let coreDataService: ICoreDataService
  let firebaseService: IFirebaseService
  
  init(coreDataService: ICoreDataService,
       firebaseService: IFirebaseService) {
    self.coreDataService = coreDataService
    self.firebaseService = firebaseService
  }
  
  func senderId() -> String? {
    firebaseService.senderId
  }
  
  func fetchedResultController(channel: Channel_db) -> NSFetchedResultsController<Message_db> {
    coreDataService.setupMessagesFetchedResultsController(channel: channel)
  }
  
  func insertMessage(channelId: String, message: String) {
    firebaseService.insertMessage(channelId: channelId, message: message)
  }
  
  func getMessages(channel: Channel_db) {
    firebaseService.getMessages(channel: channel) { [self] in
      coreDataService.saveMessages(channel, $0)
    }
  }
}
