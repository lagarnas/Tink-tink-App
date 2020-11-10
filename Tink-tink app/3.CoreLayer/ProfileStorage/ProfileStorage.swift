//
//  ProfileStorage.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 10.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

protocol IProfileStorage {
  func retriveExistingFiles(completion: @escaping (Result<Profile, Error>) -> Void)
  func writeFiles(profile: Profile, completion: @escaping (Result<Profile, Error>) -> Void)
}

class ProfileStorage: IProfileStorage {

  let fileManager = FileManager.default
  
  func retriveExistingFiles(completion: @escaping (Result<Profile, Error>) -> Void) {
    
    var profile = Profile(userName: "", userBio: "", userData: Data())
    
    do {
      if self.fileManager.fileExists(atPath: self.fileURL(.userName).path) {
        profile.userName = try String(contentsOf: self.fileURL(.userName))
      }
      
      if self.fileManager.fileExists(atPath: self.fileURL(.userBio).path) {
        profile.userBio = try String(contentsOf: self.fileURL(.userBio))
      }
      
      if self.fileManager.fileExists(atPath: self.fileURL(.userPhoto).path) {
        profile.userData = try Data(contentsOf: self.fileURL(.userPhoto))
      }
      
      completion(.success(profile))
      
    } catch let error {
      completion(.failure(error))
    }

  }
  
  func writeFiles(profile: Profile, completion: @escaping (Result<Profile, Error>) -> Void) {
    
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
      completion(.success(profile))
      
    } catch let error {
      completion(.failure(error))
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
