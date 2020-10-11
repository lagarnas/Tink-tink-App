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
  
  weak var themesVC: ThemesViewController? = ThemesViewController.loadFromStoryboard()
  
  var imageIsChanged = false
  
  var lastOffset: CGPoint!
  var keyboardHeight: CGFloat!
  
  //MARK: - Lifecycle of VC
  override func viewDidLoad() {
    nameTextField.isEnabled = false
    super.viewDidLoad()
    setImageButton.isHidden = true
    addNotifications()
    //MARK: - Retain cycle
//    themesVC?.didChangeTheme = {
//      self.updateTheme()
//    }
    nameTextField.text = "Anastasia Leonteva"
    bioTextView.text = "QA engineer, iOS developer, friendly girl, I like to learn new things"
    configure()
    os_log("%@", log: .viewCycle, type: .info, #function)
    os_log("%@", log: .frameChanged, type: .info, operationButton.frame as CVarArg)
  }
  
  
  //MARK: - IBActions
  @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
    bioTextView.isEditable = true
    setImageButton.isHidden = false
    nameTextField.isEnabled = true
  }
  
  @IBAction private func setImageButtonTapped(_ sender: UIButton) {
    openAlertAction()
  }
  
  @IBAction private func operationButtonTapped(_ sender: UIButton) {
    store(image: avatarView.imageView.image, forKey: "avatarImage")
  }
  
  @IBAction private func GCDButtonTapped(_ sender: UIButton) {
  }
  
  @IBAction private func closeButtonTapped(_ sender: UIBarButtonItem) {
    dismiss(animated: true)
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
  
  private func configure() {
    updateTheme()
    self.navigationBar.prefersLargeTitles = true
    operationButton.clipsToBounds = true
    GCDButton.clipsToBounds = true
    operationButton.layer.cornerRadius = 10
    GCDButton.layer.cornerRadius = 10
    avatarView.imageView.image = retrieveImage(forKey: "avatarImage")
   // setupInitialsOfName()
  }
  
  private func setupInitialsOfName() {
//    let nameAv = String(nameLabel.text?.first ?? " ")
//    let secondNameAv = String(nameLabel.text?.components(separatedBy: " ")[1].first ?? " ")
//    avatarView.nameLabel.text = nameAv
//    avatarView.secondNameLabel.text = secondNameAv
  }
  
  
}



