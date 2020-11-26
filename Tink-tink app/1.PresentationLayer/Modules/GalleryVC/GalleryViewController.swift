//
//  GalleryViewController.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 13.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

protocol GalleryViewControllerDelegate: class {
  func updateProfile(_ galleryViewController: GalleryViewController, urlImageData: Data)
}

class GalleryViewController: UIViewController {
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var galleryCollectionView: UICollectionView!
  
  @IBOutlet weak var emblemView: EmblemParticleView!
  private var model: IGalleryModel!
  
  weak var delegate: GalleryViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    model.delegate = self
    model.fetchGallery()
    activityIndicator.startAnimating()
    activityIndicator.hidesWhenStopped = true
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
    
    let displayModel = model.galleryOfImages[indexPath.item]
    cell.configure(galleryDisplayModel: displayModel)
    return cell
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(indexPath.item)
    let urlImage = model.galleryOfImages[indexPath.item].urlImage
    
    guard let resource = URL(string: urlImage) else { return  }
    do {
      let data = try Data(contentsOf: resource)
      delegate?.updateProfile(self, urlImageData: data)
    } catch {}
    
    self.dismiss(animated: true)
    
  }
}
