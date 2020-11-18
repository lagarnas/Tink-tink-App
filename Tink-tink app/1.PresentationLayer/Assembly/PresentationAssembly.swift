//
//  PresentationAssembly.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 09.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import UIKit

protocol IPresentationAssembly {
  
  func entryPoint() -> UINavigationController
  func profileViewController() -> ProfileViewController
  func conversationViewController() -> ConversationViewController
  func themesViewController() -> ThemesViewController
  func galleryViewController() -> GalleryViewController
}

class PresentationAssembly: IPresentationAssembly {
  
  let serviceAssembly: IServiceAssembly
  
  init(serviceAssembly: IServiceAssembly) {
    self.serviceAssembly = serviceAssembly
  }
  
  // MARK: - EntryPoint and ConversationsListViewController
  func entryPoint() -> UINavigationController {
    let storyboard = UIStoryboard(name: "ConversationsListViewController", bundle: nil)
    let rootController = storyboard.instantiateViewController(withIdentifier: "navController") as? UINavigationController
    
    let conversationsListVC = rootController?.viewControllers.first as? ConversationsListViewController
    
    conversationsListVC?.setupDepenencies(model: conversationsListModel(),
                                          themeModel: themeModel(),
                                          presentationAssembly: self)
    
    return rootController ?? UINavigationController()
  }
  
  private func conversationsListModel() -> IConversationsListModel {
    return ConversationsListModel(coreDataService: self.serviceAssembly.coreDataService,
                                  profileSaveService: self.serviceAssembly.gcdSaveService,
                                  firebaseService: self.serviceAssembly.firebaseService)
  }
  
  // MARK: - ConversationController
  func conversationViewController() -> ConversationViewController {
    let conversationVC = ConversationViewController.loadFromStoryboard() as ConversationViewController
    conversationVC.setupDepenencies(model: conversationModel(),
                                    themeModel: themeModel(),
                                    presentationAssembly: nil)
        
    return conversationVC
  }
  
  private func conversationModel() -> IConversationModel {
    return ConversationModel(coreDataService: self.serviceAssembly.coreDataService,
                             firebaseService: self.serviceAssembly.firebaseService)
  }
  
  // MARK: - ProfileViewController
  func profileViewController() -> ProfileViewController {
    let profileVC = ProfileViewController.loadFromStoryboard() as ProfileViewController
    
    profileVC.setupDepenencies(model: profileModel(savingType: profileVC.savingType),
                               themeModel: themeModel(),
                               presentationAssembly: self)
    
    return profileVC
  }
  
  private func profileModel(savingType: ProfileSavingType) -> IProfileModel {
    switch savingType {
    case .operation:
      return ProfileModel(profileService: self.serviceAssembly.operationSaveService)
    case .gcd:
      return ProfileModel(profileService: self.serviceAssembly.gcdSaveService)
    }
  }
  
  // MARK: - GalleryViewController
  func galleryViewController() -> GalleryViewController {
    let galleryVC: GalleryViewController = GalleryViewController.loadFromStoryboard() as GalleryViewController
    galleryVC.setupDepenencies(model: galleryModel(), themeModel: nil, presentationAssembly: nil)
    return galleryVC
  }
  
  private func galleryModel() -> IGalleryModel {
    return GalleryModel(loaderImagesService: self.serviceAssembly.loaderImagesService)
  }
  
  // MARK: - ThemesViewController
  func themesViewController() -> ThemesViewController {
    let themesVC: ThemesViewController = ThemesViewController.loadFromStoryboard() as ThemesViewController
    themesVC.setupDepenencies(model: themeModel(), presentationAssembly: nil)
    return themesVC
  }
  
  private func themeModel() -> IThemeModel {
    return ThemeModel(themeService: self.serviceAssembly.themeService)
  }
}
