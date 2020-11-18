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
  
  private var model: IGalleryModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    model.delegate = self
    model.fetchGallery()
    activityIndicator.startAnimating()
  }
  
  func setupDepenencies(model: IGalleryModel, themeModel: IThemeModel?, presentationAssembly: IPresentationAssembly?) {
    self.model = model
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

extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return model.currentCount
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueCell(ImageCollectionViewCell.self, for: indexPath)
      cell.configure(galleryDisplayModel: model.galleryDisplayModel(at: indexPath.item))
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(indexPath.item)
  }
}
