//
//  ProfileVC + UIImagePickerController.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 19.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit
//MARK: - Work with image, UINavigationControllerDelegate
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
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
    imageIsChanged = true
    hideInitials()
    dismiss(animated: true)
  }
  
  func store(image: UIImage?, forKey key: String) {
    guard
      let image = image,
      let pngRepresentation = image.pngData()
    else { return }
    UserDefaults.standard.set(pngRepresentation, forKey: key)
  }
  
  func retrieveImage(forKey key: String) -> UIImage? {

    if let imageData = UserDefaults.standard.object(forKey: key) as? Data,
      let image = UIImage(data: imageData) {
      
      return image
    }
      return nil
  }
}
