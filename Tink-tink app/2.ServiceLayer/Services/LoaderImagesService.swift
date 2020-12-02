//
//  LoaderImagesService.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 13.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

protocol ILoaderImagesService {
  func loadImages(completion: @escaping (Result<[Hit], NetworkingError>) -> Void)
}

class LoaderImagesService: ILoaderImagesService {

  let networkDataFetcher: INetworkDataFetcher
  
  init(networkDataFetcher: INetworkDataFetcher) {
    self.networkDataFetcher = networkDataFetcher
  }
  
  func loadImages(completion: @escaping (Result<[Hit], NetworkingError>) -> Void) {
    
    let requestConfig = RequestsFactory.PixbayAPIRequests.ImagesRequests.requestConfig()
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
