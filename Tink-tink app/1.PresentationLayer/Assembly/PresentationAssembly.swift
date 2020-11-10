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
    conversationsListVC?.presentationAssembly = self
    return rootController ?? UINavigationController()
  }
  
  private func conversationsListModel() -> IConversationsListModel {
    return ConversationsListModel(coreDataService: self.serviceAssembly.coreDataService, profileSaveService: self.serviceAssembly.gcdSaveService)
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
    profileVC.presentationAssembly = self
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

}
