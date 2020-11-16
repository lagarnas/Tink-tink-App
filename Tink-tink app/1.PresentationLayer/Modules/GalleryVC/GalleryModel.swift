//
//  GalleryModel.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 13.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

struct GalleryDisplayModel {
  let urlImage: String
  
  init(hit: Hit) {
    self.urlImage = hit.webformatURL
  }
}

protocol IGalleryModel {
  func loadImages(completion: @escaping (Result<[GalleryDisplayModel], Error>) -> Void)
}

class GalleryModel: IGalleryModel {
  
  let loaderImagesService: ILoaderImagesService
  
  init(loaderImagesService: ILoaderImagesService) {
    self.loaderImagesService = loaderImagesService
  }
  func loadImages(completion: @escaping (Result<[GalleryDisplayModel], Error>) -> Void) {
    loaderImagesService.loadImages { result in
      switch result {
      case .success(let hits):
        completion(.success(hits.getGallery()))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}

extension Array where Element == Hit {
  func getGallery() -> [GalleryDisplayModel] {
    self.map { hit -> GalleryDisplayModel in
      GalleryDisplayModel(hit: hit)
    }
  }
}
