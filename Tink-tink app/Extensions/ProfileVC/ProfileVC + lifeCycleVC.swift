//
//  ProfileVC + lifeCycleVC.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 10.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit
import os.log

//MARK: Lifecycle of VC
extension ProfileViewController {
  
  override func loadView() {
    super.loadView()
    os_log("%@", log: .viewCycle, type: .info, #function)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if avatarView.imageView.image != nil { avatarView.hideInitials() }
    os_log("%@", log: OSLog.viewCycle, type: .info, #function)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    os_log("%@", log: .viewCycle, type: .info, #function)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    os_log("%@", log: .viewCycle, type: .info, #function)
    os_log("%@", log: .frameChanged, type: .info, operationButton.frame as CVarArg)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    os_log("%@", log: .viewCycle, type: .info, #function)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    os_log("%@", log: .viewCycle, type: .info, #function)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    NSLog(#function)
  }
}
