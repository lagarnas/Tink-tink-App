//
//  OperationSaveService.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 09.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

protocol IProfileService {
  func save(profile: Profile, completion: @escaping (Result <Profile, Error>) -> Void)
  func retrive(completion: @escaping (Result<Profile, Error>) -> Void)
}

class OperationSaveService: IProfileService {
  
  let queue = OperationQueue()
  let profileStorage: IProfileStorage
  
  init(profileStorage: IProfileStorage) {
    self.profileStorage = profileStorage
  }
  
  func save(profile: Profile, completion: @escaping (Result<Profile, Error>) -> Void) {
    let saveOperation = SaveOperation(profileStorage: profileStorage, profile: profile, completion: completion)
    queue.addOperation(saveOperation)
  }
  
  func retrive(completion: @escaping (Result<Profile, Error>) -> Void) {
    let retriveOpertaion = RetriveOperation(profileStorage: profileStorage, completion: completion)
    queue.addOperation(retriveOpertaion)
  }
}

// MARK: - Save operation
class SaveOperation: RetriveOperation {
  
  var profile: Profile
  
  init(profileStorage: IProfileStorage, profile: Profile, completion: @escaping (Result<Profile, Error>) -> Void) {
    self.profile = profile
    super.init(profileStorage: profileStorage, completion: completion)
  }
  
  override func main() {
    
    profileStorage.writeFiles(profile: profile) { [weak self] result in
      switch result {
      case .success(let profile):
        self?.mainQueue.addOperation {
          self?.completion(.success(profile))
        }
        
      case .failure(let error):
        self?.mainQueue.addOperation {
          self?.completion(.failure(error))
        }
      }
    }
  }
}

// MARK: - Retrive operation
class RetriveOperation: Operation {
  
  let mainQueue = OperationQueue.main
  let profileStorage: IProfileStorage
  var completion: (Result<Profile, Error>) -> Void
  
  init(profileStorage: IProfileStorage, completion: @escaping (Result<Profile, Error>) -> Void) {
    self.profileStorage = profileStorage
    self.completion = completion
  }
  
  override func main() {
    
    profileStorage.retriveExistingFiles { [weak self] result in
      switch result {
      case .success(let profile):
        self?.mainQueue.addOperation {
          self?.completion(.success(profile))
        }
      case .failure(let error):
        self?.mainQueue.addOperation {
          self?.completion(.failure(error))
        }
      }
    }
  }
}
