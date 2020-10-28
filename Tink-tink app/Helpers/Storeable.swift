//
//  Storeable.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 14.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

protocol Storeable {
  func save(profile: Profile, completion: @escaping (Result <Profile, Error>) -> Void)
  func retrive(completion: @escaping (Result<Profile, Error>) -> Void)
}
