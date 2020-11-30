//
//  LoaderImagesService.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 13.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

protocol ILoaderImagesService {
  func loadImages(completion: @escaping (Result<[Hit], Error>) -> Void)
}

class LoaderImagesService: ILoaderImagesService {

  let networkDataFetcher: INetworkDataFetcher
  
  init(networkDataFetcher: INetworkDataFetcher) {
    self.networkDataFetcher = networkDataFetcher
  }
  
  func loadImages(completion: @escaping (Result<[Hit], Error>) -> Void) {
    
    let requestConfig = RequestsFactory.PixbayAPIRequests.ImagesRequests.imagesConfig()
    networkDataFetcher.fetchData(from: requestConfig) { result in
      switch result {
      case .success(let response):
        completion(.success(response.hits))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
