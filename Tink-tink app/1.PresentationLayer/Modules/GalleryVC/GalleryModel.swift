//
//  GalleryModel.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 13.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import UIKit

struct GalleryDisplayModel {
  let urlImageData: Data
}

protocol IGalleryModel {
  var cellsCount: Int { get }
  var currentCount: Int { get }
  
  var galleryOfImages: [GalleryDisplayModel] { get set }
  var delegate: IGalleryModelDelegate? { get set }
  
  func fetchGallery()
}

protocol IGalleryModelDelegate: class {
  func onFetchCompleted(_ galleryModel: GalleryModel)
  func onFetchFailed(error: Error)
}

class GalleryModel: IGalleryModel {

  var galleryOfImages = [GalleryDisplayModel]()
  
  weak var delegate: IGalleryModelDelegate?
  let loaderImagesService: ILoaderImagesService
  
  init(loaderImagesService: ILoaderImagesService) {
    self.loaderImagesService = loaderImagesService
  }
  
  var currentCount: Int {
      galleryOfImages.count
  }
  
  var cellsCount: Int {
    100
  }
  
  func fetchGallery() {
    loaderImagesService.loadImages { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let response):
        self.galleryOfImages.append(contentsOf: response.hits.getGallery())
        DispatchQueue.main.async {
          self.delegate?.onFetchCompleted(self)
        }
        
      case .failure(let error):
        DispatchQueue.main.async {
          self.delegate?.onFetchFailed(error: error)
        }
        
      }
    }
  }
}

extension Array where Element == Hit {
  func getGallery() -> [GalleryDisplayModel] {
    var data = Data()
    return self.map { hit -> GalleryDisplayModel in
      if let resource = URL(string: hit.previewURL) {
        do {
          data = try Data(contentsOf: resource)
        } catch {}
      }  
      return GalleryDisplayModel(urlImageData: data)
    }
  }
}
