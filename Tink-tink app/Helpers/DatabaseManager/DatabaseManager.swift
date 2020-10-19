//
//  DatabaseManager.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 18.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import Firebase

final class DatabaseManager {
  static let shared = DatabaseManager()
  private init() {}
  
  var channels = [Channel]()
  
  private let database = Firestore.firestore()
  private lazy var referanceChannels = database.collection("channels")
  private lazy var referanceChannel = database.collection("channels").document("9CSXglKAaZENJhnVwl0u")

  func insertChannel(name: String) {
    
    //Add to Array dict
    let newChannel: [String : Any] = ["name" : name,
                                      "lastActivity":  Date(),
                                      "lastMessage" : "No message yet"
    ]
    referanceChannels.addDocument(data: newChannel)

  }
  
  func getChannels(completion: @escaping (Result<[Channel], Error>) -> Void) {

    referanceChannels.addSnapshotListener { snapshot, _ in
      snapshot?.documents.compactMap {
        guard let name         = $0["name"] as? String,
              let lastActivity = $0["lastActivity"] as? Timestamp,
              let lastMessage  = $0["lastMessage"] as? String
        else {
          completion(.failure(DataBaseError.failedToFetch))
          return
        }
        self.channels.append(Channel(identifier: $0.documentID,
                                     name: name,
                                     lastMessage: lastMessage,
                                     lastActivity: Date(timeIntervalSince1970: TimeInterval(lastActivity.seconds))))
        
        completion(.success(self.channels))
      }
    }
  }
  
  enum DataBaseError: Error {
    case failedToFetch
  }
}
