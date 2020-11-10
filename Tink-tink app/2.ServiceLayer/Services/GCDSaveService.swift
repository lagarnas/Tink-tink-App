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
  
//  let fileManager = FileManager.default
  
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
      
//      do {
//        if profile.nameChanged {
//          let nameURL = self.fileURL(.userName)
//          try profile.userName.write(to: nameURL, atomically: true, encoding: .utf8)
//        }
//
//        if profile.bioChanged {
//          let bioURL = self.fileURL(.userBio)
//          try profile.userBio.write(to: bioURL, atomically: true, encoding: .utf8)
//        }
//
//        if profile.photoChanged {
//          let photoURL = self.fileURL(.userPhoto)
//          try profile.userData.write(to: photoURL)
//        }
//
//        DispatchQueue.main.async {
//          completion(.success(profile))
//        }
//
//      } catch let error {
//        DispatchQueue.main.async {
//          completion(.failure(error))
//        }
//      }
    }
  }
  
  // MARK: - Retrive data
  func retrive(completion: @escaping (Result<Profile, Error>) -> Void) {
    
//    var userName = ""
//    var userBio = ""
//    var userPhotoData = Data()
    
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
//      do {
//
//        if self.fileManager.fileExists(atPath: self.fileURL(.userName).path) {
//          userName = try String(contentsOf: self.fileURL(.userName))
//        }
//
//        if self.fileManager.fileExists(atPath: self.fileURL(.userBio).path) {
//          userBio = try String(contentsOf: self.fileURL(.userBio))
//        }
//
//        if self.fileManager.fileExists(atPath: self.fileURL(.userPhoto).path) {
//          userPhotoData = try Data(contentsOf: self.fileURL(.userPhoto))
//        }
//
//        DispatchQueue.main.async {
//          completion(.success(Profile(userName: userName, userBio: userBio, userData: userPhotoData)))
//        }
//
//      } catch let error {
//        DispatchQueue.main.async {
//          completion(.failure(error))
//        }
//      }
    }
  }
  
//  private func checkExistFile(pathComponent: URL) -> Bool {
//    if fileManager.fileExists(atPath:  pathComponent.path) {
//      return true
//    } else {
//      return false
//    }
//  }
  
//  private func fileURL(_ fileName: FileName) -> URL {
//    var documentDirURL = URL(string: "")
//    do {
//      documentDirURL = try fileManager.url(for: .documentDirectory,
//                                                in: .userDomainMask,
//                                                appropriateFor: nil,
//                                                create: true)
//    } catch  { print(error.localizedDescription) }
//    let fileURL = documentDirURL!.appendingPathComponent(fileName.rawValue)
//    return fileURL
//  }
}
