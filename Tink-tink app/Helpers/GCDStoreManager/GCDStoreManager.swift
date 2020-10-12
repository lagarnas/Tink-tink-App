//
//  StoreManager.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 12.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import UIKit


final class GCDStoreManager {
  
  private enum FileName: String {
    case userName  = "userName.txt"
    case userBio   = "userBio.txt"
    case userPhoto = "photo.png"
  }
  
  static let shared = GCDStoreManager()
  private init() {}
  
  let fileManager = FileManager.default
  let queue = DispatchQueue(label: "GCD", qos: .background, attributes: .concurrent)

  //MARK: - Save data
  func save(profile: Profile, completion: @escaping (Result<Profile, Error>)-> Void) {
    let userNameURL = self.fileURL(.userName)
    print(userNameURL)
    let userBioURL = self.fileURL(.userBio)
    print(userBioURL)
    let userPhotoURL = self.fileURL(.userPhoto)
    print(userPhotoURL)
    
    queue.async {
      sleep(2)
      do {
        
        //let urlError = URL(string: "google.com")
        
        //guard let urlError1 = urlError  else {return }
        
        try profile.userName.write(to: userNameURL, atomically: true, encoding: .utf8)
        try profile.userBio.write(to: userBioURL, atomically: true, encoding: .utf8)
        try profile.photo.write(to: userPhotoURL)
        
        //print("success saved data")
        //completion block .success
        DispatchQueue.main.async {
          completion(.success(profile))
        }
        
      } catch let error {
        //completion block .failure
        DispatchQueue.main.async {
          completion(.failure(error))
        }
      }
    }
  }
  
  
  //MARK: - Retrive data
  func retrive(completion: @escaping (Result<Profile, Error>)-> Void) {
    
    queue.async {
      do {
        let profileName = try String(contentsOf: self.fileURL(.userName))
        let profileBio = try String(contentsOf: self.fileURL(.userBio))
        let profilePhoto = try Data(contentsOf: self.fileURL(.userPhoto))
        
        DispatchQueue.main.async {
          completion(.success(Profile(userName: profileName, userBio: profileBio, photo: profilePhoto)))
        }

        
      } catch let error {
        DispatchQueue.main.async {
          completion(.failure(error))
        }
      }
    }
  }
  
  
  private func fileURL(_ fileName: FileName) -> URL {
    let documentDirURL = try! fileManager.url(for: .documentDirectory,
                                              in: .userDomainMask,
                                              appropriateFor: nil,
                                              create: true)
    let fileURL = documentDirURL.appendingPathComponent(fileName.rawValue)
    return fileURL
  }
}
