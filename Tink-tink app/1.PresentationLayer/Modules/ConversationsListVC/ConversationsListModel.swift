//
//  ConversationCellModel.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 28.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import Firebase
import CoreData

// MARK: ChannelCellDisplayModel
struct ChannelCellDisplayModel {
  var identifier: String
  var name: String
  var lastMessage: String?
  var lastActivity: Date?
}

// MARK: IConversationsListModel protocol
protocol IConversationsListModel {
  func fetchedResultController() -> NSFetchedResultsController<Channel_db>
  func retriveProfile(completion: @escaping (Result<Profile, Error>) -> Void)
  
  func insertChannel(name: String)
  func deleteChannel(channel: Channel_db)
  func getChannels()
}

class ConversationsListModel: IConversationsListModel {
  
  // MARK: Public properties
  let coreDataService: ICoreDataService
  let profileSaveService: IProfileService
  let firebaseService: IFirebaseService
  
  // MARK: Initializers
  init(coreDataService: ICoreDataService,
       profileSaveService: IProfileService,
       firebaseService: IFirebaseService) {
    
    self.coreDataService = coreDataService
    self.profileSaveService = profileSaveService
    self.firebaseService = firebaseService
  }
  
  // MARK: Public Methods
  func fetchedResultController() -> NSFetchedResultsController<Channel_db> {
    return coreDataService.setupChannelsFetchedResultsController()
  }
  
  func retriveProfile(completion: @escaping (Result<Profile, Error>) -> Void) {
    profileSaveService.retrive(completion: completion)
  }
  
  func insertChannel(name: String) {
    firebaseService.insertChannel(name: name)
  }
  
  func deleteChannel(channel: Channel_db) {
    firebaseService.deleteChannel(channel) { [self] in
      coreDataService.deleteChannel(channel)
    }
  }
  
  func getChannels() {
    firebaseService.getChannels { [self] in
      coreDataService.saveChannels($0)
    }
  }
}
