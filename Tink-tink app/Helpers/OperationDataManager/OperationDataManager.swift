//
//  OperationDataManager.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 14.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

enum FileName: String {
  case userName  = "userName.txt"
  case userBio   = "userBio.txt"
  case userPhoto = "photo.png"
  case userTheme = "theme.txt"
}

class OperationDataManager: Storeable {
  
  static let shared = OperationDataManager()
  private init() {}
  
  let queue = OperationQueue()

  func save(profile: Profile, completion: @escaping (Result<Profile, Error>) -> Void) {
    let saveOperation = SaveOperation(profile: profile, completion: completion)
    queue.addOperation(saveOperation)
    
  }
  
  func retrive(completion: @escaping (Result<Profile, Error>) -> Void) {
    let retriveOpertaion = RetriveOperation(completion: completion)
    queue.addOperation(retriveOpertaion)
  }

}

// MARK: - Save operation
class SaveOperation: RetriveOperation {
  
  var profile: Profile

  init(profile: Profile, completion: @escaping (Result<Profile, Error>) -> Void) {
    self.profile = profile
    super.init(completion: completion)
  }
  
  override func main() {
    do {
      if profile.nameChanged {
        let nameURL = self.fileURL(.userName)
        try profile.userName.write(to: nameURL, atomically: true, encoding: .utf8)
        
      }
      
      if profile.bioChanged {
        let bioURL = self.fileURL(.userBio)
        try profile.userBio.write(to: bioURL, atomically: true, encoding: .utf8)
        
      }
      
      if profile.photoChanged {
        let photoURL = self.fileURL(.userPhoto)
        try profile.userData.write(to: photoURL)
        
      }
      
      mainQueue.addOperation {
        self.completion(.success(self.profile))
      }
      
    } catch let error {
      mainQueue.addOperation {
        self.completion(.failure(error))
      }
    }
  }

}

// MARK: - Retrive operation
class RetriveOperation: Operation {
  
  let mainQueue = OperationQueue.main
  
  let fileManager = FileManager.default
  
  var userName = ""
  var userBio = ""
  var userPhotoData = Data()
  
  var completion: (Result<Profile, Error>) -> Void
  
  init(completion: @escaping (Result<Profile, Error>) -> Void) {
    self.completion = completion
  }
  
  override func main() {
    do {
      
      if self.fileManager.fileExists(atPath: self.fileURL(.userName).path) {
        userName = try String(contentsOf: self.fileURL(.userName))
      }
      
      if self.fileManager.fileExists(atPath: self.fileURL(.userBio).path) {
        userBio = try String(contentsOf: self.fileURL(.userBio))
      }
      
      if self.fileManager.fileExists(atPath: self.fileURL(.userPhoto).path) {
        userPhotoData = try Data(contentsOf: self.fileURL(.userPhoto))
      }
      
      mainQueue.addOperation {
        self.completion(.success(Profile(userName: self.userName, userBio: self.userBio, userData: self.userPhotoData)))
      }
      
    } catch let error {
      mainQueue.addOperation {
        self.completion(.failure(error))
      }
    }
  }
  
  func fileURL(_ fileName: FileName) -> URL {
    var documentDirURL = URL(string: "")
    do {
      documentDirURL = try fileManager.url(for: .documentDirectory,
                                                in: .userDomainMask,
                                                appropriateFor: nil,
                                                create: true)
    } catch  { print(error.localizedDescription) }
    let fileURL = documentDirURL!.appendingPathComponent(fileName.rawValue)
    return fileURL
  }
}
