//
//  OperationSaveService.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 09.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

enum FileName: String {
  case userName  = "userName.txt"
  case userBio   = "userBio.txt"
  case userPhoto = "photo.png"
  case userTheme = "theme.txt"
}
protocol IProfileService {
  func save(profile: Profile, completion: @escaping (Result <Profile, Error>) -> Void)
  func retrive(completion: @escaping (Result<Profile, Error>) -> Void)
}



class OperationSaveService: IProfileService {
  
  //  static let shared = OperationSaveService()
  //  private init() {}
  
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
    
    //    do {
    //      if profile.nameChanged {
    //        let nameURL = self.fileURL(.userName)
    //        try profile.userName.write(to: nameURL, atomically: true, encoding: .utf8)
    //
    //      }
    //
    //      if profile.bioChanged {
    //        let bioURL = self.fileURL(.userBio)
    //        try profile.userBio.write(to: bioURL, atomically: true, encoding: .utf8)
    //
    //      }
    //
    //      if profile.photoChanged {
    //        let photoURL = self.fileURL(.userPhoto)
    //        try profile.userData.write(to: photoURL)
    //
    //      }
    //
    //      mainQueue.addOperation {
    //        self.completion(.success(self.profile))
    //      }
    //
    //    } catch let error {
    //      mainQueue.addOperation {
    //        self.completion(.failure(error))
    //      }
    //    }
  }
  
}

// MARK: - Retrive operation
class RetriveOperation: Operation {
  
  let mainQueue = OperationQueue.main
  
 // let fileManager = FileManager.default
  
  let profileStorage: IProfileStorage
  
  //  var userName = ""
  //  var userBio = ""
  //  var userPhotoData = Data()
  
  //var profile = Profile(userName: "", userBio: "", userData: Data())
  
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
    //    do {
    //
    //      if self.fileManager.fileExists(atPath: self.fileURL(.userName).path) {
    //        profile.userName = try String(contentsOf: self.fileURL(.userName))
    //      }
    //
    //      if self.fileManager.fileExists(atPath: self.fileURL(.userBio).path) {
    //        profile.userBio = try String(contentsOf: self.fileURL(.userBio))
    //      }
    //
    //      if self.fileManager.fileExists(atPath: self.fileURL(.userPhoto).path) {
    //        profile.userData = try Data(contentsOf: self.fileURL(.userPhoto))
    //      }
    //
    //      mainQueue.addOperation {
    //        self.completion(.success(self.profile))
    //      }
    //
    //    } catch let error {
    //      mainQueue.addOperation {
    //        self.completion(.failure(error))
    //      }
    //    }
  }
  
  //  func fileURL(_ fileName: FileName) -> URL {
  //    var documentDirURL = URL(string: "")
  //    do {
  //      documentDirURL = try fileManager.url(for: .documentDirectory,
  //                                           in: .userDomainMask,
  //                                           appropriateFor: nil,
  //                                           create: true)
  //    } catch  { print(error.localizedDescription) }
  //    let fileURL = documentDirURL!.appendingPathComponent(fileName.rawValue)
  //    return fileURL
  //  }
}
