//
//  UICollectionViewDataSource.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 16.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

// MARK: Private properties
private let itemsPerRow: CGFloat = 3
private let sectionInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

// MARK: UICollectionViewDelegateFlowLayout
extension GalleryViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
        
    let paddingWidth = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = collectionView.frame.width - paddingWidth
    
    let itemWidth: CGFloat = availableWidth / itemsPerRow
    let itemSize: CGSize = CGSize(width: itemWidth, height: itemWidth)
    
    return itemSize
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    sectionInsets
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    sectionInsets.left
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    0
  }
}

// MARK: Extension UICollectionView + generic func dequeueCell<T: UICollectionViewCell>
extension UICollectionView {
  func dequeueCell<Cell: UICollectionViewCell>(_ cellType: Cell.Type, for indexPath: IndexPath) -> Cell {
    guard let cell = dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
      fatalError("Unable to dequeue \(Cell.self)")
    }
    return cell
  }
}
