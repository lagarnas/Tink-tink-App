//
//  ProfileVC + UIImagePickerController.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 19.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit
// MARK: - Work with image, UINavigationControllerDelegate
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func openAlertAction() {
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
    camera.titleTextColor = .black
    
    let photo = UIAlertAction(title: "Photo", style: .default) { _ in
      self.chooseImagePicker(source: .photoLibrary)
    }
    
    photo.setValue(photoIcon, forKey: "image")
    photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
    photo.titleTextColor = .black
    
    let cancel = UIAlertAction(title: "Cancel", style: .cancel)
    cancel.titleTextColor = .red
    
    actionSheet.addAction(camera)
    actionSheet.addAction(photo)
    actionSheet.addAction(cancel)
    actionSheet.pruneNegativeWidthConstraints()
    present(actionSheet, animated: true)
  }
  
  func chooseImagePicker(source: UIImagePickerController.SourceType) {
    
    guard UIImagePickerController.isSourceTypeAvailable(source) else { return }
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    imagePicker.sourceType = source
    present(imagePicker, animated:  true)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    avatarView.imageView.image = info[.editedImage] as? UIImage
    avatarView.imageView.contentMode = .scaleAspectFill
    avatarView.imageView.clipsToBounds = true
    self.profile?.userData = avatarView.imageView.image?.pngData() ?? Data()
    self.profile?.photoChanged = true
    avatarView.hideInitials()
    enabledButtons()
    
    dismiss(animated: true)
  }
}
