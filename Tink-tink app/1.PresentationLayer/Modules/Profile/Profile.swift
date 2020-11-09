//
//  Profile.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 12.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

struct Profile {
  
  var userName: String
  var userBio: String
  var userData: Data
  
  var nameChanged: Bool = false
  var bioChanged: Bool = false
  var photoChanged: Bool = false

}
