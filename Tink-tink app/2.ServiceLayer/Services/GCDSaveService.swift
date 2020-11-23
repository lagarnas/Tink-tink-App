//
//  GCDSaveService.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 09.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

final class GCDSaveService: IProfileService {
  
  let profileStorage: IProfileStorage
  
  init(profileStorage: IProfileStorage) {
    self.profileStorage = profileStorage
  }
  
  let queue = DispatchQueue(label: "GCD", qos: .background, attributes: .concurrent)
  let mainQueue = DispatchQueue.main
  
  // MARK: - Save data
  func save(profile: Profile, completion: @escaping (Result <Profile, Error>) -> Void) {
    queue.async {
      self.profileStorage.writeFiles(profile: profile) {[weak self] result in
        switch result {
        case .success(let profile):
          self?.mainQueue.async {
            completion(.success(profile))
          }
        case .failure(let error):
          self?.mainQueue.async {
            completion(.failure(error))
          }
        }
      }
    }
  }
  
  // MARK: - Retrive data
  func retrive(completion: @escaping (Result<Profile, Error>) -> Void) {
    queue.async {
      
      self.profileStorage.retriveExistingFiles { [weak self] result in
        switch result {
        case .success(let profile):
          self?.mainQueue.async {
            completion(.success(profile))
          }
        case .failure(let error):
          self?.mainQueue.async {
            completion(.failure(error))
          }
        }
      }
    }
  }
}
