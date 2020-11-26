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
  @IBOutlet weak var editButton: UIButton!
  
  @IBOutlet weak var emblemView: EmblemParticleView!
  
  var lastOffset: CGPoint!
  var keyboardHeight: CGFloat!
  var GCDButtonIsClick = false
  var savingType: ProfileSavingType = .gcd
  
  private var isAnimate: Bool = false
  
  //DEPENDENCY
  var presentationAssembly: IPresentationAssembly!
  var profile: Profile!
  var model: IProfileModel!
  var themeModel: IThemeModel!
  
  // MARK: - Lifecycle of VC
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configure()
    
    os_log("%@", log: .viewCycle, type: .info, #function)
    os_log("%@", log: .frameChanged, type: .info, operationButton.frame as CVarArg)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    emblemView.stopAnimation()
    editButton.layer.cornerRadius = 10
    editButton.layer.borderWidth = 2
    editButton.layer.borderColor = UIColor.black.cgColor
  }
  
  func setupDepenencies(model: IProfileModel?,
                        themeModel: IThemeModel?,
                        presentationAssembly: IPresentationAssembly?) {
    self.model = model
    self.themeModel = themeModel
    self.presentationAssembly = presentationAssembly
  }
  
  // MARK: - Configure
  private func configure() {
    profile = Profile(userName: nameTextField.text ?? "", userBio: bioTextView.text, userData: avatarView.imageView.image?.pngData() ?? Data())
    
    updateTheme()
    addNotifications()
    unEnabledUIElements()
    setupInitialsOfName()
    configUI()
    getProfile()
  }
  
  private func getProfile() {
    guard let model = self.model else { return }
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
  }
  
  // MARK: - IBActions
  @IBAction private func editButtonTapped(_ sender: UIButton) {
    
    if isAnimate {
      unEnabledUIElements()
      unEnabledButtons()
      stopAnimate()
      
    } else {
      enabledUIElements()
      enabledButtons()
      shake(button: sender)
      nameTextField.becomeFirstResponder()
    }
  }
  
  private func shake(button: UIButton) {
    
    var animations = [CAAnimation]()
    
    let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
    rotation.values = [0,
                       NSNumber(value: Double.pi / 10),
                       0,
                       NSNumber(value: -Double.pi / 10),
                       0]
    rotation.isCumulative = true
    
    let animationX = CAKeyframeAnimation(keyPath: "transform.translation.x")
    animationX.values = [0, -5, 0, 5]
    animationX.isAdditive = true
    
    let animationY = CAKeyframeAnimation(keyPath: "transform.translation.y")
    animationY.values = [0, -5, 0, 5]
    animationY.isAdditive = true
    
    animations.append(rotation)
    animations.append(animationY)
    animations.append(animationX)
    
    let group = CAAnimationGroup()
    group.duration = 0.3
    group.repeatCount = .infinity
    group.autoreverses = true
    group.delegate = self
    group.animations = animations
    group.isRemovedOnCompletion = true
    group.fillMode = .removed
    group.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    
    CATransaction.setCompletionBlock {
      print("all animations completed")
    }
    
    button.layer.add(group, forKey: "shake")
  }
  
  private func stopAnimate() {
    self.editButton.layer.removeAnimation(forKey: "shake")
    isAnimate = false
  }
  
  @IBAction private func setImageButtonTapped(_ sender: UIButton) {
    openAlertAction()
  }
  
  // MARK: - operationButtonTapped()
  @IBAction func operationButtonTapped(_ sender: UIButton) {
    unEnabledButtons()
    activityIndicator.startAnimating()
    guard let profile = self.profile
    else { return }
    model.save(profile: profile) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success:
        self.updateUI()
        self.stopAnimate()
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
        self.stopAnimate()
      case .failure:
        self.alertError(title: "Error", message: "Failed to save data", style: .alert)
      }
    }
  }
  
  // MARK: - closeButtonTapped()
  @IBAction private func closeButtonTapped(_ sender: UIBarButtonItem) {
    dismiss(animated: true)
  }
  
  deinit {
    os_log("%@", log: .retainCycle, type: .info, self)
  }
}

extension ProfileViewController: CAAnimationDelegate {
  func animationDidStart(_ anim: CAAnimation) {
    isAnimate = true
  }
}
