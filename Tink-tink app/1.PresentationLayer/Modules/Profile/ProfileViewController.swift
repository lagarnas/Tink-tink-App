//
//  ViewController.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 11.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit
import os.log

enum ProfileSavingType {
  case operation
  case gcd
}

final class ProfileViewController: UIViewController {
  
  // MARK: - @IBOutlets
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
  @IBOutlet weak var nameSeparator: UIView!
  @IBOutlet weak var bioSeparator: UIView!
  @IBOutlet weak var editButton: UIBarButtonItem!
  
  var lastOffset: CGPoint!
  var keyboardHeight: CGFloat!
  var GCDButtonIsClick = false

  var savingType: ProfileSavingType = .gcd
  
  //DEPENDENCY
  var presentationAssembly: IPresentationAssembly?
  var operationModel: IProfileModel?
  var model: IProfileModel?
  
  var profile: Profile?
  
  // MARK: - Lifecycle of VC
  override func viewDidLoad() {
    super.viewDidLoad()
    profile = Profile(userName: nameTextField.text ?? "", userBio: bioTextView.text, userData: avatarView.imageView.image?.pngData() ?? Data())
    
    self.configure()
    guard let model = self.model
    else { return }
    
    model.retriveProfile { [weak self] result in
      guard let self = self
      else { return }
      switch result {
      case .success(let profile):
        self.nameTextField.text = profile.userName
        self.bioTextView.text = profile.userBio
        self.avatarView.imageView.image = UIImage(data: profile.userData)
        self.setupInitialsOfName()
      case .failure(let error):
        print(error.localizedDescription)
      }
      
    }
    
    os_log("%@", log: .viewCycle, type: .info, #function)
    os_log("%@", log: .frameChanged, type: .info, operationButton.frame as CVarArg)
  }
  
  // MARK: - Configure
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
  
  private func enabledUIElements() {
    setImageButton.isHidden = false
    nameTextField.isEnabled = true
    bioTextView.isEditable = true
  }
  
  private func unEnabledUIElements() {
    setImageButton.isHidden = true
    nameTextField.isEnabled = false
    bioTextView.isEditable = false
    unEnabledButtons()
  }
  
  // MARK: - IBActions
  @IBAction private func editButtonTapped(_ sender: UIBarButtonItem) {
    enabledUIElements()
    editButton.isEnabled = false
    nameTextField.becomeFirstResponder()
  }
  
  @IBAction private func setImageButtonTapped(_ sender: UIButton) {
    openAlertAction()
    
  }
  
  // MARK: - operationButtonTapped()
  @IBAction func operationButtonTapped(_ sender: UIButton) {
    unEnabledButtons()
    activityIndicator.startAnimating()
    guard let profile = self.profile,
          let operationModel = self.operationModel
    else { return }
    operationModel.save(profile: profile) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success:
        self.updateUI()
      case .failure:
        self.alertError(title: "Error", message: "Failed to save data", style: .alert)
      }
      
    }
  }
  
  // MARK: - GCDButtonTapped()
  @objc func GCDButtonTapped() {
    GCDButtonIsClick = true
    activityIndicator.startAnimating()
    unEnabledButtons()
    
    guard let profile = self.profile,
          let model = self.model
    else { return }
    model.save(profile: profile) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success:
        self.updateUI()
      case .failure:
        self.alertError(title: "Error", message: "Failed to save data", style: .alert)
      }
    }
  }
  
  private func updateUI() {
    activityIndicator.stopAnimating()
    alert(title: "Data saved", message: "", style: .alert)
    setupInitialsOfName()
    unEnabledUIElements()
    editButton.isEnabled = true
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

// MARK: - Functions
extension ProfileViewController {
  
  func hideInitials() {
    avatarView.nameLabel.isHidden = true
    avatarView.secondNameLabel.isHidden = true
  }
  
  private func setupInitialsOfName() {
    if avatarView.imageView.image != nil {
      avatarView.hideInitials()
    } else {
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

extension ProfileViewController {
  func updateTheme() {
    ThemeManager.shared.applyTheme()
    view.backgroundColor = ThemeManager.shared.current.backgroundAppColor
    scrollView.backgroundColor = ThemeManager.shared.current.backgroundAppColor
    contentView.backgroundColor = ThemeManager.shared.current.backgroundAppColor
    
    nameLabel.textColor = ThemeManager.shared.current.mainTextColor
    nameTextField.textColor = ThemeManager.shared.current.mainTextColor
    nameSeparator.backgroundColor = ThemeManager.shared.current.accent
    
    bioLabel.textColor = ThemeManager.shared.current.mainTextColor
    bioTextView.backgroundColor = ThemeManager.shared.current.backgroundAppColor
    bioTextView.textColor = ThemeManager.shared.current.mainTextColor
    bioSeparator.backgroundColor = ThemeManager.shared.current.accent
    
    operationButton.backgroundColor = ThemeManager.shared.current.accent
    operationButton.setTitleColor(ThemeManager.shared.current.tintColor, for: .normal)
    
    GCDButton.backgroundColor = ThemeManager.shared.current.accent
    GCDButton.setTitleColor(ThemeManager.shared.current.tintColor, for: .normal)
  }
}

extension ProfileViewController {
  
  func alert(title: String, message: String, style: UIAlertController.Style) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
    
    let action = UIAlertAction(title: "OK", style: .default)
    
    alertController.addAction(action)
    
    self.present(alertController, animated: true, completion: nil)
  }
  
  func alertError(title: String, message: String, style: UIAlertController.Style) {
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
    
    let actionOK = UIAlertAction(title: "OK", style: .default) {_ in
      self.activityIndicator.stopAnimating()
    }
    let actionRepeat = UIAlertAction(title: "Try again", style: .default) {_ in
      
      if self.GCDButtonIsClick {
        self.GCDButtonTapped()
      } else {
        self.operationButtonTapped(self.operationButton)
      }
      
    }
    alertController.addAction(actionOK)
    alertController.addAction(actionRepeat)
    
    self.present(alertController, animated: true, completion: nil)
  }
}
