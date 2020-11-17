//
//  GalleryViewController.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 13.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var galleryCollectionView: UICollectionView!
  var galleryModel: IGalleryModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    galleryModel.delegate = self
    galleryModel.fetchGallery()
    activityIndicator.startAnimating()
  }
}

extension GalleryViewController: IGalleryModelDelegate {
  func onFetchCompleted(_ galleryModel: GalleryModel) {
    activityIndicator.stopAnimating()
    self.galleryCollectionView.reloadData()
    
  }
  
  func onFetchFailed(error: Error) {
    print(error.localizedDescription)
  }
}

extension GalleryViewController: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return galleryModel.currentCount
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueCell(ImageCollectionViewCell.self, for: indexPath)
      cell.configure(galleryDisplayModel: galleryModel.galleryDisplayModel(at: indexPath.item))
    
    return cell
  }
}
