//
//  ServiceAssembly.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 09.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

protocol IServiceAssembly {
  var coreDataService: ICoreDataService { get }
  var operationSaveService: IProfileService { get }
  var gcdSaveService: IProfileService { get }
  var firebaseService: IFirebaseService { get }
  var themeService: IThemeService { get }
}

class ServiceAssembly: IServiceAssembly {
  private let coreAssembly: ICoreAssembly
  init(coreAssembly: ICoreAssembly) {
    self.coreAssembly = coreAssembly
  }
  
  lazy var coreDataService: ICoreDataService = CoreDataService(coreDataStorage: self.coreAssembly.coreDataStorage)
  lazy var operationSaveService: IProfileService = OperationSaveService(profileStorage: self.coreAssembly.profileStorage)
  lazy var gcdSaveService: IProfileService = GCDSaveService(profileStorage: self.coreAssembly.profileStorage)
  lazy var firebaseService: IFirebaseService = FirebaseService(firebaseStorage: self.coreAssembly.firebaseStorage)
  lazy var themeService: IThemeService = ThemeService(themeStorage: self.coreAssembly.themeStorage)
  
}
