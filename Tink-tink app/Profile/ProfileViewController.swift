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
  
  @IBOutlet weak var navigationBar: UINavigationBar!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var bioLabel: UILabel!
  @IBOutlet weak var saveButton: UIButton!
  @IBOutlet weak var avatarView: AvatarView!
  
  var imageIsChanged = false
  private let defaults = UserDefaults.standard
  
  //MARK: - Lifecycle of VC
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    os_log("%@", log: .viewCycle, type: .info, #function)
    os_log("%@", log: .frameChanged, type: .info, saveButton.frame as CVarArg)
  }
  
  
  //MARK: - IBActions
  @IBAction private func editButtonTapped(_ sender: UIButton) {
    openAlertAction()
  }
  @IBAction private func saveButtonTapped(_ sender: UIButton) {
    store(image: avatarView.imageView.image, forKey: "avatarImage")
  }
  @IBAction private func closeButtonTapped(_ sender: UIBarButtonItem) {
    dismiss(animated: true)
  }
}

//MARK: - Functions
extension ProfileViewController {
  
  func hideInitials() {
    avatarView.nameLabel.isHidden = true
    avatarView.secondNameLabel.isHidden = true
  }
  
  private func configure() {
    self.navigationBar.backgroundColor = .white
    self.navigationBar.prefersLargeTitles = true
    saveButton.clipsToBounds = true
    saveButton.layer.cornerRadius = 10
    nameLabel.text = "Anastasia Leonteva"
    bioLabel.text = "iOS developer, QA engineer, Russia, Samara"
    avatarView.imageView.image = retrieveImage(forKey: "avatarImage")
    setupInitialsOfName()
  }
  
  private func setupInitialsOfName() {
    let nameAv = String(nameLabel.text?.first ?? " ")
    let secondNameAv = String(nameLabel.text?.components(separatedBy: " ")[1].first ?? " ")
    avatarView.nameLabel.text = nameAv
    avatarView.secondNameLabel.text = secondNameAv
  }
  
  private func openAlertAction() {
    // создаем экземпляр класса UIAlertController
    let cameraIcon = #imageLiteral(resourceName: "camera")
    let photoIcon = #imageLiteral(resourceName: "photo")
    let actionSheet = UIAlertController(title: nil,
                                        message: nil,
                                        preferredStyle: .actionSheet)
    
    let camera = UIAlertAction(title: "Camera", style: .default) { _ in
      self.chooseImagePicker(source: .camera)
    }
    
    camera.setValue(cameraIcon, forKey: "image")
    camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
    
    let photo = UIAlertAction(title: "Photo", style: .default) { _ in
      self.chooseImagePicker(source: .photoLibrary)
    }
    
    photo.setValue(photoIcon, forKey: "image")
    photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
    
    let cancel = UIAlertAction(title: "Cancel", style: .cancel)
    
    actionSheet.addAction(camera)
    actionSheet.addAction(photo)
    actionSheet.addAction(cancel)
    actionSheet.pruneNegativeWidthConstraints()
    present(actionSheet, animated: true)
  }

}


//MARK: Lyfecycle of VC
extension ProfileViewController {
  // Загрузка вью
  override func loadView() {
    super.loadView()
    os_log("%@", log: .viewCycle, type: .info, #function)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if avatarView.imageView.image != nil { hideInitials() }
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
    os_log("%@", log: .frameChanged, type: .info, saveButton.frame as CVarArg)
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
