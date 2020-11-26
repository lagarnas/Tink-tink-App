//
//  CoreAssembly.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 09.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

protocol ICoreAssembly {
  var coreDataStorage: ICoreDataStorage { get }
  var profileStorage: IProfileStorage { get }
  var firebaseStorage: IFirebaseStorage { get }
  var themeStorage: IThemeStorage { get }
  var networkDataFetcher: INetworkDataFetcher { get }
}

class CoreAssembly: ICoreAssembly {
  
  lazy var profileStorage: IProfileStorage = ProfileStorage()
  lazy var coreDataStorage: ICoreDataStorage = CoreDataStorage()
  lazy var firebaseStorage: IFirebaseStorage = FirebaseStorage()
  lazy var themeStorage: IThemeStorage = ThemeStorage()
  lazy var networkDataFetcher: INetworkDataFetcher = NetworkDataFetcher()
}
