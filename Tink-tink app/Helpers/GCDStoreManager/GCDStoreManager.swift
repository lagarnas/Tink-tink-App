//
//  StoreManager.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 12.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import UIKit


enum FileName: String {
  case userName  = "userName.txt"
  case userBio   = "userBio.txt"
  case userPhoto = "photo.png"
}

final class GCDStoreManager {
  
  static let shared = GCDStoreManager()
  private init() {}
  
  let fileManager = FileManager.default
  let queue = DispatchQueue(label: "GCD", qos: .background, attributes: .concurrent)
  
  
  //MARK: - Save data
  

  func save(profile: Profile, completion: @escaping (Result <Any?, Error>) -> Void) {
    
    queue.async {
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
        
        DispatchQueue.main.async {
          completion(.success(nil))
        }
        
      } catch let error {
        DispatchQueue.main.async {
          completion(.failure(error))
        }
      }
    }
  }
  
  
  
  //MARK: - Retrive data
  func retrive(completion: @escaping (Result<Profile, Error>) -> Void) {
    
    var userName = ""
    var userBio = ""
    var userPhotoData = Data()
    
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    let url = NSURL(fileURLWithPath: path)
    
    queue.async {
      do {
        
        //check file name
        if let pathComponent = url.appendingPathComponent("userName.txt") {
          let filePath = pathComponent.path
          let fileManager = FileManager.default
          if fileManager.fileExists(atPath: filePath) {
            userName = try String(contentsOf: self.fileURL(.userName))
          }
        }
        //check file bio
        if let pathComponent = url.appendingPathComponent("userBio.txt") {
          let filePath = pathComponent.path
          let fileManager = FileManager.default
          if fileManager.fileExists(atPath: filePath) {
            userBio = try String(contentsOf: self.fileURL(.userBio))
          }
        }
        //check file photo
        if let pathComponent = url.appendingPathComponent("photo.png") {
          let filePath = pathComponent.path
          let fileManager = FileManager.default
          if fileManager.fileExists(atPath: filePath) {
            userPhotoData = try Data(contentsOf: self.fileURL(.userPhoto))
          }
        }
        
        
        DispatchQueue.main.async {
          completion(.success(Profile(userName: userName, userBio: userBio, userData: userPhotoData)))
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
