//
//  ViewController.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 11.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UINavigationControllerDelegate {
  
  @IBOutlet weak var avatarImageView: AvatarImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var bioLabel: UILabel!
  @IBOutlet weak var avatarNameLabel: UILabel!
  @IBOutlet weak var avatarSecondNameLabel: UILabel!
  
  var imageIsChanged = false
  let defaults = UserDefaults.standard
  
  //MARK: - Lifecycle of VC
  // Загрузка вью
  override func loadView() {
    super.loadView()
    NSLog(#function)
  }
  
  // Вью загружена
  override func viewDidLoad() {
    super.viewDidLoad()
    NSLog(#function)
    configure()
    
  }
  // Вью начинает появляться
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if avatarImageView != nil {
      avatarNameLabel.isHidden = true
      avatarSecondNameLabel.isHidden = true
    }
    NSLog(#function)
  }
  // Вот вот у вью изменятся фреймы будь осторожен
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    NSLog(#function)
  }
  // Ну вот фреймы изменились, надеюсь ты успел?
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    NSLog(#function)
  }
  // Вью появилась
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    NSLog(#function)
  }
  // Вью вот вот исчезнет
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NSLog(#function)
  }
  // Вью исчезла =(
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    NSLog(#function)
  }
  
  //MARK: -Functions
  
  private func configure() {
    nameLabel.text = "Anastasia Leonteva"
    bioLabel.text = "iOS developer, QA engineer, Russia, Samara"
    avatarImageView.image = retrieveImage(forKey: "avatarImage")
    setupInitialsOfName()
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
    avatarImageView.isUserInteractionEnabled = true
    avatarImageView.addGestureRecognizer(tapGestureRecognizer)
  }
  
  private func setupInitialsOfName() {
    let nameAv = String(nameLabel.text?.first ?? " ")
    let secondNameAv = String(nameLabel.text?.components(separatedBy: " ")[1].first ?? " ")
    print(nameAv, secondNameAv)
    avatarNameLabel.text = nameAv
    avatarSecondNameLabel.text = secondNameAv
  }
  
  @IBAction func editButtonTapped(_ sender: UIButton) {
    openAlertAction()
  }
  @IBAction func saveButtonTapped(_ sender: UIButton) {
    store(image: avatarImageView.image, forKey: "avatarImage")
  }
  
  @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
    let _ = tapGestureRecognizer.view as! AvatarImageView
    openAlertAction()
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
  

  //Оповещает что у телефона нехватка памяти
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    NSLog(#function)
  }
}




