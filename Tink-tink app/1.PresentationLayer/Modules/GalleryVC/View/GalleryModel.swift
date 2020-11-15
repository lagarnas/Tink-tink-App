//
//  GalleryModel.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 13.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

protocol IGalleryModel {
  func loadImages()
}

class GalleryModel: IGalleryModel {

  let loaderImagesService: ILoaderImagesService
  
  init(loaderImagesService: ILoaderImagesService) {
    self.loaderImagesService = loaderImagesService
  }
  func loadImages() {
    loaderImagesService.loadImages { result in
      switch result {
      case .success(let data):
        print(data)
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
}
