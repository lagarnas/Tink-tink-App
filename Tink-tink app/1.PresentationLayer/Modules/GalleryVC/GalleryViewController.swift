//
//  GalleryViewController.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 13.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

// MARK: GalleryViewController delegate protocol
protocol GalleryViewControllerDelegate: class {
  func updateProfile(_ galleryViewController: GalleryViewController, urlImageData: Data)
}

final class GalleryViewController: UIViewController {  
  // MARK: IBOutlets
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var galleryCollectionView: UICollectionView!
  @IBOutlet weak var emblemView: EmblemParticleView!
  
  // MARK: Public properties
  weak var delegate: GalleryViewControllerDelegate?
  
  // MARK: Private properties
  private var model: IGalleryModel!
  
  // MARK: Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    model.delegate = self
    model.fetchGallery()
    setupActivityIndicator()
  }
  
  // MARK: Public Methods
  func setupDepenencies(model: IGalleryModel, themeModel: IThemeModel?, presentationAssembly: IPresentationAssembly?) {
    self.model = model
  }
  
  // MARK: Private Methods
  private func setupActivityIndicator() {
    activityIndicator.startAnimating()
    activityIndicator.hidesWhenStopped = true
  }
  
  // MARK: IBActions
  @IBAction func closeButton(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true)
  }
  
}

// MARK: - IGalleryModelDelegate
extension GalleryViewController: IGalleryModelDelegate {
  
  func onFetchCompleted(_ galleryModel: GalleryModel) {
    activityIndicator.stopAnimating()
    galleryCollectionView.reloadData()
  }
  
  func onFetchFailed(error: Error) {
    activityIndicator.stopAnimating()
    galleryCollectionView.reloadData()
    self.alert(title: "Error", message: error.localizedDescription, style: .alert)
  }
}

// MARK: Collection View Data Source, Delegate
extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

    return model.currentCount
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueCell(ImageCollectionViewCell.self, for: indexPath)
    
    if model.galleryOfImages.isEmpty {
      cell.configure(galleryDisplayModel: nil)
    } else {
      let displayModel = model.galleryOfImages[indexPath.item]
      cell.configure(galleryDisplayModel: displayModel)
    }
    
    return cell
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(indexPath.item)
    let urlImage = model.galleryOfImages[indexPath.item].urlImageData
    
    delegate?.updateProfile(self, urlImageData: urlImage)
    self.dismiss(animated: true)
    
  }
}
