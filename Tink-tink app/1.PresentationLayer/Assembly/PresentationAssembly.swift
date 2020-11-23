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
}

class PresentationAssembly: IPresentationAssembly {
  
  let serviceAssembly: IServiceAssembly
  
  init(serviceAssembly: IServiceAssembly) {
    self.serviceAssembly = serviceAssembly
  }
  
  // MARK: - EntryPoint and ConversationsListViewController
  func entryPoint() -> UINavigationController {
    let model = conversationsListModel()
    let storyboard = UIStoryboard(name: "ConversationsListViewController", bundle: nil)
    let rootController = storyboard.instantiateViewController(withIdentifier: "navController") as? UINavigationController
    
    let conversationsListVC = rootController?.viewControllers.first as? ConversationsListViewController
    conversationsListVC?.model = model
    conversationsListVC?.themeModel = themeModel()
    conversationsListVC?.presentationAssembly = self
    return rootController ?? UINavigationController()
  }
  
  private func conversationsListModel() -> IConversationsListModel {
    return ConversationsListModel(coreDataService: self.serviceAssembly.coreDataService,
                                  profileSaveService: self.serviceAssembly.gcdSaveService,
                                  firebaseService: self.serviceAssembly.firebaseService)
  }
  
  // MARK: - ConversationController
  func conversationViewController() -> ConversationViewController {
    let model = conversationModel()
    let conversationVC = ConversationViewController.loadFromStoryboard() as ConversationViewController
    conversationVC.model = model
    conversationVC.themeModel = themeModel()
    
    return conversationVC
  }
  
  private func conversationModel() -> IConversationModel {
    return ConversationModel(coreDataService: self.serviceAssembly.coreDataService,
                             firebaseService: self.serviceAssembly.firebaseService)
  }
  
  // MARK: - ProfileViewController
  func profileViewController() -> ProfileViewController {
    
    let profileVC = ProfileViewController.loadFromStoryboard() as ProfileViewController
    
    switch profileVC.savingType {
    case .gcd:
      let model = profileModel(savingType: .gcd)
      profileVC.model = model
    case .operation:
      let model = profileModel(savingType: .operation)
      profileVC.model = model
    }
    profileVC.operationModel = profileModel(savingType: .operation)
    profileVC.themeModel = themeModel()
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
  
  // MARK: - ThemesViewController
  func themesViewController() -> ThemesViewController {
    let themesVC: ThemesViewController = ThemesViewController.loadFromStoryboard() as ThemesViewController
    themesVC.model = themeModel()
    return themesVC
  }
  
  private func themeModel() -> IThemeModel {
    return ThemeModel(themeService: self.serviceAssembly.themeService)
  }
}
