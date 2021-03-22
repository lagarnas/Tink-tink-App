//
//  ImageCell.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 16.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
  // MARK: IBOutlets
  @IBOutlet weak var imageView: UIImageView!
  
  // MARK: Lifecycle
  override func prepareForReuse() {
    super.prepareForReuse()
    setupPlaceholder()
  }
  
  // MARK: Public Methods
  func configure(galleryDisplayModel: GalleryDisplayModel?) {
    
    guard let galleryDisplayModel = galleryDisplayModel
    else {
      setupPlaceholder()
      return
    }
    
    self.imageView.image = UIImage(data: galleryDisplayModel.urlImageData)
    deletePlaceholder()
  }
  
  // MARK: Private Methods
  private func setupPlaceholder() {
    imageView.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
    imageView.contentMode = .center
    imageView.image = #imageLiteral(resourceName: "placeholder")
  }
  
  private func deletePlaceholder() {
    imageView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    imageView.contentMode = .scaleAspectFill
    
  }
}
