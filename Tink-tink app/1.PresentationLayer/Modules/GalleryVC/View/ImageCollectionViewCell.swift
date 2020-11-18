//
//  ImageCell.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 16.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var imageView: UIImageView!
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.configure(galleryDisplayModel: .none)
  }
  
  func configure(galleryDisplayModel: GalleryDisplayModel?) {
    if let galleryDisplayModel = galleryDisplayModel {
      guard let resource = URL(string: galleryDisplayModel.urlImage) else {
        setupPlaceHolder()
        return }
      do {
        let data = try Data(contentsOf: resource)
        imageView.image = UIImage(data: data)

      } catch {}
    }
  }
  
  private func setupPlaceHolder() {
    imageView.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
    imageView.contentMode = .center
    imageView.image = #imageLiteral(resourceName: "placeholder")
  }
}
