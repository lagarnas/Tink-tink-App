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
  
  private let database = Firestore.firestore()
  private lazy var referanceChannels = database.collection("channels")
  let senderId = UIDevice.current.identifierForVendor?.uuidString
  
  var messages = [Message]()
  
  func insertChannel(name: String) {
    
    let newChannel: [String : Any] = ["name"        : name,
                                      "lastActivity":  Date(),
                                      "lastMessage" : "No message yet"]
    referanceChannels.addDocument(data: newChannel)
  }
  
  func getChannels(completion: @escaping (Result<[Channel], Error>) -> Void) {
    
    referanceChannels.addSnapshotListener { snapshot, _ in
      var channels = [Channel]()
      _ = snapshot?.documents.compactMap {
        guard let name         = $0["name"] as? String,
              let lastActivity = $0["lastActivity"] as? Timestamp,
              let lastMessage  = $0["lastMessage"] as? String
        else {
          completion(.failure(DataBaseError.failedToFetch))
          return
        }
        channels.append(Channel(identifier: $0.documentID,
                                     name: name,
                                     lastMessage: lastMessage,
                                     lastActivity: Date(timeIntervalSince1970: TimeInterval(lastActivity.seconds))))
      }
      completion(.success(channels))
      channels = []
    }
  }
  
  func insertMessage(channelId: String, message: String) {
    guard let senderId = self.senderId else { return }
    let newMessage: [String: Any] = ["content": message,
                                      "created": Date(),
                                      "senderName": "🐷",
                                      "senderId": senderId]

    referanceChannels.document(channelId).collection("messages").addDocument(data: newMessage)
  }
  
  func getMessages(channelId: String, completion: @escaping (Result<[Message], Error>) -> Void) {
    referanceChannels.document(channelId)
      .collection("messages").addSnapshotListener { (snapshot, _) in
        _ = snapshot?.documents.compactMap {
          guard
            let senderId = $0["senderId"] as? String,
            let senderName = $0["senderName"] as? String,
            let content = $0["content"] as? String,
            let created = $0["created"] as? Timestamp
          else { return }
          self.messages.append(Message(senderId: senderId,
                                       senderName: senderName,
                                       content: content,
                                       created: Date(timeIntervalSince1970: TimeInterval(created.seconds))))
          
        }
        completion(.success(self.messages))
        self.messages = []
      }
  }
  
  enum DataBaseError: Error {
    case failedToFetch
  }
}
