//
//  ViewController.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 11.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit
import os.log

final class ProfileViewController: UIViewController {
  
  //MARK: - @IBOutlets
  @IBOutlet weak var navigationBar: UINavigationBar!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var bioLabel: UILabel!
  @IBOutlet weak var operationButton: UIButton!
  @IBOutlet weak var GCDButton: UIButton!
  @IBOutlet weak var avatarView: AvatarView!
  @IBOutlet weak var setImageButton: UIButton!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var bioTextView: UITextView!
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var constraintContentHeight: NSLayoutConstraint!
  @IBOutlet weak var textStackView: UIStackView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  weak var themesVC: ThemesViewController? = ThemesViewController.loadFromStoryboard()
  
  var lastOffset: CGPoint!
  var keyboardHeight: CGFloat!
  
  let dataManager: Storeable = OperationDataManager.shared
  
  var profile: Profile?
  
  //MARK: - Lifecycle of VC
  override func viewDidLoad() {
    super.viewDidLoad()
    profile = Profile(userName: nameTextField.text ?? "", userBio: bioTextView.text, userData: avatarView.imageView.image?.pngData() ?? Data())
    
    //MARK: - Retain cycle
    //    themesVC?.didChangeTheme = {
    //      self.updateTheme()
    //    }
    
    self.configure()
    
    dataManager.retrive { result in
      switch result {
      case .success(let profile):
        self.nameTextField.text = profile.userName
        self.bioTextView.text  = profile.userBio
        self.avatarView.imageView.image = UIImage(data: profile.userData)
        self.setupInitialsOfName()
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
    
    os_log("%@", log: .viewCycle, type: .info, #function)
    os_log("%@", log: .frameChanged, type: .info, operationButton.frame as CVarArg)
  }
  
  
  //MARK: - Configure
  private func configure() {
    
    updateTheme()
    addNotifications()
    unEnabledUIElements()
    setupInitialsOfName()
    
    activityIndicator.stopAnimating()
    activityIndicator.hidesWhenStopped = true
    
    operationButton.clipsToBounds = true
    operationButton.layer.cornerRadius = 10
    
    GCDButton.clipsToBounds = true
    GCDButton.layer.cornerRadius = 10
    GCDButton.addTarget(self, action: #selector(GCDButtonTapped), for: .touchUpInside)
    

  }
  
  
  func enabledUIElements() {
    setImageButton.isHidden = false
    nameTextField.isEnabled = true
    bioTextView.isEditable = true
  }
  
  func unEnabledUIElements() {
    setImageButton.isHidden = true
    nameTextField.isEnabled = false
    bioTextView.isEditable = false
    unEnabledButtons()
  }
  
  
  
  //MARK: - IBActions
  @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
    enabledUIElements()
  }
  
  @IBAction private func setImageButtonTapped(_ sender: UIButton) {
    openAlertAction()
  }
  
  @IBAction private func operationButtonTapped(_ sender: UIButton) {
    guard let profile = self.profile else { return }
    dataManager.save(profile: profile) { (result) in
      switch result {
      case .success(_):
        self.activityIndicator.stopAnimating()
        self.alert(title: "Data saved", message: "", style: .alert)
        self.setupInitialsOfName()
      case .failure(_):
        self.alertError(title: "Error", message: "Failed to save data", style: .alert)
      }
    }
  }
  
  @objc
  func GCDButtonTapped() {
    activityIndicator.startAnimating()
 
    // MARK: - GCD save
    guard let profile = self.profile else { return }
    
    dataManager.save(profile: profile) { result in
      switch result {
      case .success(_):
        self.activityIndicator.stopAnimating()
        self.alert(title: "Data saved", message: "", style: .alert)
        self.setupInitialsOfName()
      case .failure(_):
        self.alertError(title: "Error", message: "Failed to save data", style: .alert)
      }
    }
  }
  
  
  @IBAction private func closeButtonTapped(_ sender: UIBarButtonItem) {
    dismiss(animated: true)
  }
  
  func enabledButtons() {
    self.GCDButton.isEnabled = true
    self.operationButton.isEnabled = true
  }
  
  func unEnabledButtons() {
    GCDButton.isEnabled = false
    operationButton.isEnabled = false
  }
  
  
  
  deinit {
    os_log("%@", log: .retainCycle, type: .info, self)
  }
}

//MARK: - Functions
extension ProfileViewController {
  
  func hideInitials() {
    avatarView.nameLabel.isHidden = true
    avatarView.secondNameLabel.isHidden = true
  }

  
  private func setupInitialsOfName() {
    if avatarView.imageView.image != nil {
      avatarView.hideInitials()
    }
    else {
      guard let tf = nameTextField.text else { return }
      let fullName = tf
      let fullNameArr = fullName.components(separatedBy: " ")
      let firstName: String = fullNameArr[0]
      let lastName: String? = fullNameArr.count > 1 ? fullNameArr[1] : nil
      
      let firstInitial = String(firstName.first ?? " ")
      let secondInitial = String(lastName?.first ?? " ")
      
      avatarView.nameLabel.text = firstInitial
      avatarView.secondNameLabel.text = secondInitial
    }
  }
}


