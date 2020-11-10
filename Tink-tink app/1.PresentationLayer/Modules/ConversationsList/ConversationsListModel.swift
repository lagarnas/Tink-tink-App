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

struct ChannelCellDisplayModel {
    var identifier: String
    var name: String
    var lastMessage: String?
    var lastActivity: Date?
}

protocol IConversationsListModel {
  func fetchedResultController() -> NSFetchedResultsController<Channel_db>
  func retriveProfile(completion: @escaping (Result<Profile, Error>) -> Void)
}

class ConversationsListModel: IConversationsListModel {
  let coreDataService: ICoreDataService
  let profileSaveService: IProfileService
  
  init(coreDataService: ICoreDataService, profileSaveService: IProfileService) {
    self.coreDataService = coreDataService
    self.profileSaveService = profileSaveService
  }
  
  func fetchedResultController() -> NSFetchedResultsController<Channel_db> {
    return coreDataService.setupChannelsFetchedResultsController()
  }
  
  func retriveProfile(completion: @escaping (Result<Profile, Error>) -> Void) {
    profileSaveService.retrive(completion: completion)
  }
  
}
