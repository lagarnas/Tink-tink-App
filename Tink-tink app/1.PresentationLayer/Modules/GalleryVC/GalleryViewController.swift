//
//  GalleryViewController.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 13.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  var galleryModel: IGalleryModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  var gallery: [GalleryDisplayModel] = []
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    print(collectionView.visibleCells.count)
    galleryModel?.loadImages { [weak self] result in
      switch result {
      case .success(let gallery):
        print(gallery.count)
        self?.gallery = gallery
        self?.collectionView.reloadData()
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
}

extension GalleryViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    gallery.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueCell(ImageCollectionViewCell.self, for: indexPath)
    let galleryItem = self.gallery[indexPath.item]
    cell.configure(urlImage: galleryItem.urlImage)
    return cell
  }
  
}
