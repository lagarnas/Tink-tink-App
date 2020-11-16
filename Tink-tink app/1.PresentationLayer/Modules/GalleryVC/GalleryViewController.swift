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
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    print(collectionView.visibleCells.count)
    galleryModel?.loadImages()
  }
}

extension GalleryViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    30
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueCell(ImageCollectionViewCell.self, for: indexPath)
    return cell
  }
  
}
